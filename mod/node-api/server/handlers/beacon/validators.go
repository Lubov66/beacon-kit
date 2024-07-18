package beacon

import (
	"context"
	"net/http"

	types "github.com/berachain/beacon-kit/mod/node-api/server/types"
	"github.com/berachain/beacon-kit/mod/node-api/server/utils"
	echo "github.com/labstack/echo/v4"
)

func (h Handler[_]) GetStateValidators(c echo.Context) error {
	params, err := utils.BindAndValidate[types.StateValidatorsGetRequest](c)
	if err != nil {
		return err
	}
	if params == nil {
		return echo.ErrInternalServerError
	}
	if len(params.Status) > 0 {
		return echo.ErrNotImplemented
	}
	validators, err := h.backend.GetStateValidators(
		context.TODO(),
		params.StateID,
		params.ID,
		params.Status,
	)
	if err != nil {
		return err
	}
	if len(validators) == 0 {
		return echo.NewHTTPError(http.StatusNotFound, "State not found")
	}
	return c.JSON(http.StatusOK, types.ValidatorResponse{
		ExecutionOptimistic: false, // stubbed
		Finalized:           false, // stubbed
		Data:                validators})
}

func (h Handler[_]) PostStateValidators(c echo.Context) error {
	params, err := utils.BindAndValidate[types.StateValidatorsPostRequest](c)
	if err != nil {
		return err
	}
	if params == nil {
		return echo.ErrInternalServerError
	}
	validators, err := h.backend.GetStateValidators(
		context.TODO(),
		params.StateID,
		params.IDs,
		params.Statuses,
	)
	if err != nil {
		return err
	}
	return c.JSON(http.StatusOK, types.ValidatorResponse{
		ExecutionOptimistic: false, // stubbed
		Finalized:           false, // stubbed
		Data:                validators})
}

func (h Handler[_]) GetStateValidatorBalances(c echo.Context) error {
	params, err := utils.BindAndValidate[types.ValidatorBalancesGetRequest](c)
	if err != nil {
		return err
	}
	if params == nil {
		return echo.ErrInternalServerError
	}
	balances, err := h.backend.GetStateValidatorBalances(
		context.TODO(),
		params.StateID,
		params.ID,
	)
	if err != nil {
		return err
	}
	return c.JSON(http.StatusOK, types.ValidatorResponse{
		ExecutionOptimistic: false, // stubbed
		Finalized:           false, // stubbed
		Data:                balances,
	})
}

func (h Handler[_]) PostStateValidatorBalances(c echo.Context) error {
	params := &types.ValidatorBalancesPostRequest{}
	if err := (&echo.DefaultBinder{}).BindBody(c, &params.IDs); err != nil {
		return err
	}
	pathParamErr := echo.PathParamsBinder(c).
		String("state_id", &params.StateID).
		BindError()
	if pathParamErr != nil {
		return pathParamErr
	}
	if err := c.Validate(params); err != nil {
		return err
	}
	balances, err := h.backend.GetStateValidatorBalances(
		context.TODO(),
		params.StateID,
		params.IDs,
	)
	if err != nil {
		return err
	}
	return c.JSON(http.StatusOK, types.ValidatorResponse{
		ExecutionOptimistic: false, // stubbed
		Finalized:           false, // stubbed
		Data:                balances,
	})
}

func (h Handler[_]) GetBlockRewards(c echo.Context) error {
	params, err := utils.BindAndValidate[types.BlockIDRequest](c)
	if err != nil {
		return err
	}
	if params == nil {
		return echo.ErrInternalServerError
	}
	rewards, err := h.backend.GetBlockRewards(context.TODO(), params.BlockID)
	if err != nil {
		return err
	}
	return c.JSON(http.StatusOK, types.ValidatorResponse{
		ExecutionOptimistic: false, // stubbed
		Finalized:           false, // stubbed
		Data:                rewards,
	})
}