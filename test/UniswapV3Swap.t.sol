// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/UniswapV3Swap.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

// For this example, we will set the pool fee to 0.3%.
uint24 constant poolFee = 3000;

contract UniV3Test is Test {
    IWETH private weth = IWETH(WETH);
    IERC20 private dai = IERC20(DAI);
    IERC20 private usdc = IERC20(USDC);

    UniswapV3Swap private uni = new UniswapV3Swap();

    function setUp() public {}

    function testSingleHop() public {
        weth.deposit{value: 1e18}();
        weth.approve(address(uni), 1e18);

        uint amountOut = uni.swapExactInputSingleHop(WETH, DAI, poolFee, 1e18);

        console.log("DAI", amountOut / 1e18 );
    }

    /* function testMultiHop() public {
        weth.deposit{value: 1e18}();
        weth.approve(address(uni), 1e18);

        bytes memory path = abi.encodePacked(
            WETH,
            poolFee,
            USDC,
            uint24(100),
            DAI
        );

        uint amountOut = uni.swapExactInputMultiHop(path, WETH, 1e18);

        console.log("DAI", amountOut);
    } */
}
