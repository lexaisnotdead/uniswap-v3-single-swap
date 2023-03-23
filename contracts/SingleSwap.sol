// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.17;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}

contract SingleSwap {
    address public constant swapRouterAddress = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    
    ISwapRouter public constant swapRouter = ISwapRouter(swapRouterAddress);
    IERC20 public tokenAInterface;

    address public tokenA;
    address public tokenB;

    uint24 public constant poolFee = 3000;

    function setTokens(address _tokenA, address _tokenB) external {
        require(_tokenA != address(0), "Wrong address for token A");
        require(_tokenB != address(0), "Wrong address for token B");

        tokenA = _tokenA;
        tokenB = _tokenB;

        tokenAInterface = IERC20(_tokenA);
    }

    modifier checkTokens() {
        require(tokenA != address(0), "Token A is not initialized");
        require(tokenB != address(0), "Token B is not initialized");
        _;
    }

    function swapExactInputSingle(uint256 amountIn) external checkTokens returns (uint256 amountOut) {
        tokenAInterface.approve(address(swapRouter), amountIn);

        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: tokenA,
                tokenOut: tokenB,
                fee: poolFee,
                recipient: address(this),
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        amountOut = swapRouter.exactInputSingle(params);
    }

    function swapExactOutputSingle(uint256 amountOut, uint256 amountInMaximum) external checkTokens returns (uint256 amountIn) {
        tokenAInterface.approve(address(swapRouter), amountInMaximum);

        ISwapRouter.ExactOutputSingleParams memory params =
            ISwapRouter.ExactOutputSingleParams({
                tokenIn: tokenA,
                tokenOut: tokenB,
                fee: poolFee,
                recipient: address(this),
                deadline: block.timestamp,
                amountOut: amountOut,
                amountInMaximum: amountInMaximum,
                sqrtPriceLimitX96: 0
            });

        amountIn = swapRouter.exactOutputSingle(params);

        if (amountIn < amountInMaximum) {
            tokenAInterface.approve(address(swapRouter), 0);
            tokenAInterface.transfer(address(this), amountInMaximum - amountIn);
        }
    }
}