SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Stake.sol";
import "../test/mocks/MockERC20.sol";

contract StakeTest is Test {
    Stake public _stake;
  MVPWAIR public m;

    address StakingAdmin;
    // address USER = 

   function setUp() public {
       m = new MVP(StakingAdmin);
      _stake = new Stake(address(m));
       vm.startPrank(StakingAdmin);
       ERC20(address(m)).transfer(address(_stake), 40_000e18);
       ERC20(address(m)).transfer(USER, 1_000e18);
       vm.stopPrank();
   }

   function testStaking() public {
       vm.startPrank(USER);
       ERC20(address(m)).approve(address(_stake), 1_000e30);
       uint totalbalanceBefore = getB();
       _stake.stake(500e18);
       assertApproxEqAbs(getB(), totalbalanceBefore - 500e18, 1e18);
       totalbalanceBefore -= 500e18;
       vm.warp(block.timestamp + 30 days);
       _stake.withdraw(100e18);
       assertApproxEqAbs(getB(), totalbalanceBefore + 150e18, 1e18);
       _stake.getUserData(USER);
       vm.warp(block.timestamp + 90 days);
       _stake.stake(0);
         assertEq(ERC20(address(t)).balanceOf(USER),x)
   }

   function getB() internal view returns (uint) {
       return ERC20(address(m)).balanceOf(USER);
   }

   function mkaddr(string memory name) public returns (address) {
       address addr = address(
           uint160(uint256(keccak256(abi.encodePacked(name))))
       );
       vm.label(addr, name);
       return addr;
   }
}




   

