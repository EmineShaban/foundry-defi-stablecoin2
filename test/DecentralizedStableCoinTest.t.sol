// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {console} from "forge-std/Script.sol";
import {Test} from "forge-std/Test.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract DecentralizedStableCoinTest is Test {
    DecentralizedStableCoin dsc;

    function setUp() public {
        dsc = new DecentralizedStableCoin();
    }

    function testMustMintMoreThanZero() public {
        vm.prank(dsc.owner());
        vm.expectRevert(DecentralizedStableCoin.DecentralizedStableCoin__MustBeMoreThanZero.selector);
        dsc.mint(address(this), 0);
    }

    function testMustBurnMoreThanZero() public {
        address owner = dsc.owner(); // Get the contract owner
        vm.prank(owner); // Act as the owner
        dsc.mint(owner, 100); // Mint tokens to the owner

        vm.prank(owner); // Act as the owner again for burning
        vm.expectRevert(DecentralizedStableCoin.DecentralizedStableCoin__MustBeMoreThanZero.selector);
        dsc.burn(0); // Attempt to burn 0 tokens (should revert)
    }

    function testCantBurnMoreThanYouHave() public {
        address owner = dsc.owner(); // Get the contract owner
        vm.prank(owner); // Act as the owner
        dsc.mint(owner, 100); // Mint tokens to the owner

        vm.prank(owner); // Act as the owner again for burning
        vm.expectRevert();
        dsc.burn(1000); // Attempt to burn 0 tokens (should revert)
    }

    function testCantMintToZeroAddress() public {
        vm.prank(dsc.owner());
        vm.expectRevert(DecentralizedStableCoin.DecentralizedStableCoin__NotZeroAddress.selector);
        dsc.mint(address(0), 100);
    }
}
