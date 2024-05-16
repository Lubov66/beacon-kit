// SPDX-License-Identifier: MIT
//
// Copyright (c) 2024 Berachain Foundation
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

package client

import (
	"strings"

	"github.com/berachain/beacon-kit/mod/errors"
	engineerrors "github.com/berachain/beacon-kit/mod/primitives-engine/pkg/errors"
	jsonrpc "github.com/berachain/beacon-kit/mod/primitives/pkg/net/json-rpc"
	gethRPC "github.com/ethereum/go-ethereum/rpc"
)

// ErrUnauthenticatedConnection indicates that the connection is not
// authenticated.
//
//nolint:lll
const UnauthenticatedConnectionErrorStr = `could not verify execution chain ID as your 
	connection is not authenticated. If connecting to your execution client via HTTP, you 
	will need to set up JWT authentication...`

var (
	// ErrNotStarted indicates that the execution client is not started.
	ErrNotStarted = errors.New("engine client is not started")

	// ErrInvalidJWTSecretLength indicates incorrect JWT secret length.
	ErrInvalidJWTSecretLength = errors.New("invalid JWT secret length")

	// ErrHTTPTimeout indicates a timeout error from http.Client.
	ErrHTTPTimeout = errors.New("timeout from http.Client")
)

// Handles errors received from the RPC server according to the specification.
func (s *EngineClient[ExecutionPayloadDenebT]) handleRPCError(err error) error {
	if err == nil {
		return nil
	}
	if isTimeout(err) {
		return ErrHTTPTimeout
	}
	e, ok := err.(gethRPC.Error) //nolint:errorlint // from prysm.
	if !ok {
		if strings.Contains(err.Error(), "401 Unauthorized") {
			authErrMsg := "HTTP authentication to your execution client " +
				"is not working. Please ensure you are setting a correct " +
				"value for the JWT secret path" +
				"is set correctly, or use an IPC " +
				"connection if on the same machine."
			s.logger.Error(authErrMsg)
			return errors.Newf("could not authenticate connection to "+
				"execution client: %w", err)
		}
		return errors.Wrapf(err, "got an unexpected error in JSON-RPC response")
	}
	switch e.ErrorCode() {
	case -32700:
		// telemetry.IncrCounter(1, MetricKeyParseErrorCount)
		return jsonrpc.ErrParse
	case -32600:
		// telemetry.IncrCounter(1, MetricKeyInvalidRequestCount)
		return jsonrpc.ErrInvalidRequest
	case -32601:
		// telemetry.IncrCounter(1, MetricKeyMethodNotFoundCount)
		return jsonrpc.ErrMethodNotFound
	case -32602:
		// telemetry.IncrCounter(1, MetricKeyInvalidParamsCount)
		return jsonrpc.ErrInvalidParams
	case -32603:
		// telemetry.IncrCounter(1, MetricKeyInternalErrorCount)
		return jsonrpc.ErrInternal
	case -38001:
		// telemetry.IncrCounter(1, MetricKeyUnknownPayloadErrorCount)
		return engineerrors.ErrUnknownPayload
	case -38002:
		// telemetry.IncrCounter(1, MetricKeyInvalidForkchoiceStateCount)
		return engineerrors.ErrInvalidForkchoiceState
	case -38003:
		// telemetry.IncrCounter(1, MetricKeyInvalidPayloadAttributesCount)
		return engineerrors.ErrInvalidPayloadAttributes
	case -38004:
		// telemetry.IncrCounter(1, MetricKeyRequestTooLargeCount)
		return engineerrors.ErrRequestTooLarge
	case -32000:
		// telemetry.IncrCounter(1, MetricKeyInternalServerErrorCount)
		// Only -32000 status codes are data errors in the RPC specification.
		var errWithData gethRPC.DataError
		errWithData, ok = err.(gethRPC.DataError) //nolint:errorlint // from prysm.
		if !ok {
			return errors.Wrapf(
				err, "got an unexpected error in JSON-RPC response")
		}
		return errors.Wrapf(jsonrpc.ErrServer, "%v", errWithData.Error())
	default:
		return err
	}
}

// httpTimeoutError defines an interface for timeout errors.
// It includes methods for error message retrieval and timeout status checking.
type httpTimeoutError interface {
	// Error returns the error message.
	Error() string
	// Timeout indicates whether the error is a timeout error.
	Timeout() bool
}

// isTimeout checks if the given error is a timeout error.
// It asserts the error to the httpTimeoutError interface and checks its Timeout
// status.
// Returns true if the error is a timeout error, false otherwise.
func isTimeout(e error) bool {
	if e == nil {
		return false
	}
	//nolint:errorlint // by design.
	t, ok := e.(httpTimeoutError)
	return ok && t.Timeout()
}
