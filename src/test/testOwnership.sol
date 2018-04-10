pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BaseOwnership.sol";

contract TestOwnership {
  BaseOwnership base = BaseOwnership(DeployedAddresses.BaseOwnership());

  //First attempt at testing approve and takeownership
  function testApprove() public {
    magic_number = 9;
    approve(msg.sender, magic_number);

    takeOwnership(magic_number);//if successful what should happen?
  }

}
