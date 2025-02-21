// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {console} from "forge-std/Script.sol";
import {Test} from "forge-std/Test.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DSCEngineTest is Test {
    DeployDSC deployer;
    DecentralizedStableCoin dsc;
    DSCEngine dsce;
    HelperConfig config;
    address ethUsdPriceFeed;
    address btcUsdPriceFeed;
    address weth;

    address public USER = makeAddr("user");
    uint256 public constant AMOUNT_COLLATERAL = 10 ether;
    uint256 amountToMint = 100 ether;
    uint256 public constant STARTING_USER_BALANCE = 10 ether;

    function setUp() public {
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        (ethUsdPriceFeed, btcUsdPriceFeed, weth,,) = config.activeNetworkConfig();
        ERC20Mock(weth).mint(USER, STARTING_USER_BALANCE);
    }

    address[] public tokenAddresses;
    address[] public priceFeedAddresses;

    ///////////////////////
    // Constructor Tests //
    ///////////////////////

    function testRevertIfTokenLengthDoesntMuchPriceFeeds() public {
        priceFeedAddresses.push(ethUsdPriceFeed);
        tokenAddresses.push(weth);
        priceFeedAddresses.push(btcUsdPriceFeed);

        vm.expectRevert(DSCEngine.DSCEngine__TokenAddressesAndPriceFeedAddressesMustBeSameLength.selector);
        new DSCEngine(tokenAddresses, priceFeedAddresses, address(dsc));
    }

    /////////////////
    // Price Tests //
    /////////////////

    function testGetUsdValue() public {
        // 15e18 * 2,000/ETH = 30,000e18
        uint256 ethAmount = 15e18;
        uint256 expectedUsd = 30000e18;
        uint256 actualUsd = dsce.getUsdValue(weth, ethAmount);
        assertEq(expectedUsd, actualUsd);
    }

    function testGetTokenAmountFromUsd() public {
        // 15e18 * 2,000/ETH = 30,000e18
        uint256 expectedWeth = 0.05 ether;
        uint256 amountWeth = dsce.getTokenAmountFromUsd(weth, 100 ether);
        assertEq(amountWeth, expectedWeth);
    }

    /////////////////////////////
    // depositCollateral Tests //
    /////////////////////////////

    function testRevertsIfCollateralZero() public {
        vm.startPrank(USER);
        ERC20Mock(weth).approve(address(dsce), AMOUNT_COLLATERAL);

        vm.expectRevert(DSCEngine.DSCEngine__NeedsMoreThanZero.selector);
        dsce.depositCollateral(weth, 0);
        vm.stopPrank();
    }

    modifier depositCollateral() {
        vm.startPrank(USER);
        ERC20Mock(weth).approve(address(dsce), AMOUNT_COLLATERAL);
        dsce.depositCollateral(weth, AMOUNT_COLLATERAL);
        vm.stopPrank();
        _;
    }

    function testCanDepositCollateralAndGetAccountInfo() public depositCollateral {
        (uint256 totalDscMinted, uint256 collateralValueInUsd) = dsce.getAccountInformation(USER);

        uint256 expectedTotalDscMinted = 0;

        uint256 expectedDepositAmount = dsce.getTokenAmountFromUsd(weth, collateralValueInUsd);

        assertEq(AMOUNT_COLLATERAL, expectedDepositAmount);
    }
}

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
