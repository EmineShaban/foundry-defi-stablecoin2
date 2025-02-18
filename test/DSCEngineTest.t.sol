// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {console} from "forge-std/Script.sol";
import {Test} from "forge-std/Test.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../src/DSCEngine.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DSCEngineTest is Test {
    // DSCEngine public dsce;
    // DecentralizedStableCoin public dsc;
    // HelperConfig public helperConfig;

    // address public ethUsdPriceFeed;
    // address public btcUsdPriceFeed;
    // address public weth;
    // address public wbtc;
    // uint256 public deployerKey;

    // uint256 amountCollateral = 10 ether;
    // uint256 amountToMint = 100 ether;
    // address public user = address(1);

    // uint256 public constant STARTING_USER_BALANCE = 10 ether;
    // uint256 public constant MIN_HEALTH_FACTOR = 1e18;
    // uint256 public constant LIQUIDATION_THRESHOLD = 50;

    // function setUp() external {
    //     DeployDSC deployer = new DeployDSC();
    //     (dsc, dsce, helperConfig) = deployer.run();
    //     (ethUsdPriceFeed, btcUsdPriceFeed, weth, wbtc, deployerKey) = helperConfig.activeNetworkConfig();
    //     if (block.chainid == 31_337) {
    //         vm.deal(user, STARTING_USER_BALANCE);
    //     }
    //     // Should we put our integration tests here?
    //     // else {
    //     //     user = vm.addr(deployerKey);
    //     //     ERC20Mock mockErc = new ERC20Mock("MOCK", "MOCK", user, 100e18);
    //     //     MockV3Aggregator aggregatorMock = new MockV3Aggregator(
    //     //         helperConfig.DECIMALS(),
    //     //         helperConfig.ETH_USD_PRICE()
    //     //     );
    //     //     vm.etch(weth, address(mockErc).code);
    //     //     vm.etch(wbtc, address(mockErc).code);
    //     //     vm.etch(ethUsdPriceFeed, address(aggregatorMock).code);
    //     //     vm.etch(btcUsdPriceFeed, address(aggregatorMock).code);
    //     // }
    //     ERC20Mock(weth).mint(user, STARTING_USER_BALANCE);
    //     ERC20Mock(wbtc).mint(user, STARTING_USER_BALANCE);
    // }
    // ///////////////////////////////////////
    // // depositCollateral Tests //
    // ///////////////////////////////////////

    // // this test needs it's own setup
    // function testRevertsIfTransferFromFails() public {
    //     // Arrange - Setup
    // }

    // function testRevertsIfCollateralZero() public {
    //     vm.prank(user);
    //     ERC20Mock(weth).approve(address(dsce), amountCollateral);
    // }

    // function testRevertsWithUnapprovedCollateral() public {}

    // modifier depositedCollateral() {}

    // function testCanDepositCollateralWithoutMinting() public depositedCollateral {}

    // function testCanDepositedCollateralAndGetAccountInfo() public depositedCollateral {}
}
