# Uniswap V3 Single Swap
Swaps are the most common interaction with the Uniswap protocol. This is my implementation of a single-path swap contract that uses three functions:

* ``` swapExactInputSingle ```
* ``` swapExactOutputSingle ```
* ``` setTokens ```

The ```swapExactInputSingle``` function is for performing *exact input* swaps, which swap a fixed amount of one token for a maximum possible amount of another token. This function uses the ```ExactInputSingleParams``` struct and the ```exactInputSingle``` function from the [ISwapRouter](https://docs.uniswap.org/contracts/v3/reference/periphery/interfaces/ISwapRouter) interface.

The ```swapExactOutputSingle``` function is for performing *exact output* swaps, which swap a minimum possible amount of one token for a fixed amount of another token. This function uses the ```ExactOutputSingleParams``` struct and the ```exactOutputSingle``` function from the [ISwapRouter](https://docs.uniswap.org/contracts/v3/reference/periphery/interfaces/ISwapRouter) interface.

The ```setTokens``` function is for setting a pair of tokens.
## Goerli

[Link](https://goerli.etherscan.io/address/0x433FA8ADD133905A1f65dFFaD3587c3D6d4a1Bf7#code) to the verified contract in the goerli network