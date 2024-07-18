// SPDX-License-Identifier: BUSL-1.1
//
// Copyright (C) 2024, Berachain Foundation. All rights reserved.
// Use of this software is governed by the Business Source License included
// in the LICENSE file of this repository and at www.mariadb.com/bsl11.
//
// ANY USE OF THE LICENSED WORK IN VIOLATION OF THIS LICENSE WILL AUTOMATICALLY
// TERMINATE YOUR RIGHTS UNDER THIS LICENSE FOR THE CURRENT AND ALL OTHER
// VERSIONS OF THE LICENSED WORK.
//
// THIS LICENSE DOES NOT GRANT YOU ANY RIGHT IN ANY TRADEMARK OR LOGO OF
// LICENSOR OR ITS AFFILIATES (PROVIDED THAT YOU MAY USE A TRADEMARK OR LOGO OF
// LICENSOR AS EXPRESSLY REQUIRED BY THIS LICENSE).
//
// TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE LICENSED WORK IS PROVIDED ON
// AN “AS IS” BASIS. LICENSOR HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS,
// EXPRESS OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND
// TITLE.

package routes

import (
	"github.com/berachain/beacon-kit/mod/node-api/server/handlers"
	"github.com/labstack/echo/v4"
)

func assignBeaconRoutes[ValidatorT any](
	e *echo.Echo,
	h handlers.RouteHandlers[ValidatorT],
) {
	e.GET("/eth/v1/beacon/genesis",
		h.GetGenesis)
	e.GET("/eth/v1/beacon/states/:state_id/root",
		h.GetStateRoot)
	e.GET("/eth/v1/beacon/states/:state_id/fork",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/states/:state_id/finality_checkpoints",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/states/:state_id/validators",
		h.GetStateValidators)
	e.POST("/eth/v1/beacon/states/:state_id/validators",
		h.PostStateValidators)
	e.GET("/eth/v1/beacon/states/:state_id/validators/:validator_id",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/states/:state_id/validator_balances",
		h.GetStateValidatorBalances)
	e.POST("/eth/v1/beacon/states/:state_id/validator_balances",
		h.PostStateValidatorBalances)
	e.GET("/eth/v1/beacon/states/:state_id/committees",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/states/:state_id/sync_committees",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/states/:state_id/randao",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/headers",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/headers/:block_id",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/blocks/blinded_blocks",
		h.NotImplemented)
	e.POST("/eth/v2/beacon/blocks/blinded_blocks",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/blocks",
		h.NotImplemented)
	e.POST("/eth/v2/beacon/blocks",
		h.NotImplemented)
	e.GET("/eth/v2/beacon/blocks/:block_id",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/blocks/:block_id/root",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/blocks/:block_id/attestations",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/blob_sidecars/:block_id",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/rewards/sync_committee/:block_id",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/deposit_snapshot",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/rewards/attestation/:epoch",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/blinded_blocks/:block_id",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/light_client/bootstrap/:block_root",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/light_client/updates",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/light_client/finality_update",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/light_client/optimistic_update",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/pool/attestations",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/pool/attestations",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/pool/attester_slashings",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/pool/attester_slashings",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/pool/proposer_slashings",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/pool/proposer_slashings",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/pool/sync_committees",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/pool/voluntary_exits",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/pool/voluntary_exits",
		h.NotImplemented)
	e.GET("/eth/v1/beacon/pool/bls_to_execution_changes",
		h.NotImplemented)
	e.POST("/eth/v1/beacon/pool/bls_to_execution_changes",
		h.NotImplemented)
}
