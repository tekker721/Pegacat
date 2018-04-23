pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BaseOwnership.sol";
import "../contracts/TokenMinting.sol";


//@dev testing the functions in BaseOwnership.sol
//@pre TokenMinting.sol works and all the test cases in testCreate.sol pass
//@author Patrick Guo & Niaz Makhdum
contract testOwnership {
  TokenMinting tokens = TokenMinting(DeployedAddresses.TokenMinting());
  //BaseOwnership base = BaseOwnership(DeployedAddresses.BaseOwnership());
  address owner = msg.sender;

  //test Address to transfer tokens to
  address testAddress = 0x627306090abaB3A6e1400e9345bC60c78a8BEf57;

  //create a token and test that its owner has 1 token
  function testBalanceOf() public {
    uint tokenId =  uint(keccak256("ALEX01"));

    tokens.createToken(msg.sender,tokenId);
    Assert.equal(uint(1),tokens.balanceOf(msg.sender),"The owner should have 1 token");
  }

  //create a token and transfer it to the testAddress
  function testTransfer() public {
    uint tokenId = uint(keccak256("NIAZ09"));

    tokens.createToken(msg.sender,tokenId);
    tokens.transfer(testAddress,tokenId);
    Assert.equal(testAddress, tokens.ownerOf(tokenId), "The owner of the token should be the test address");
  }

  //create a token and approve its transfer to a testAddress
  /* function testApprove() public {
    uint tokenId = uint(keccak256("PATRICK12"));

    tokens.createToken(msg.sender,tokenId);
    base.approve(testAddress,tokenId);
    Assert.equal(testAddress,base.tokenApprovals[tokenId],"The token should be present in tokenApprovals list");
  } */

  //create a token, approve its transfer and then its change ownership
  function testTakeOwnership() public {
    uint tokenId = uint(keccak256("ITSCHILL04"));

    tokens.createToken(testAddress,tokenId);
    tokens.approve(msg.sender,tokenId);
    tokens.takeOwnership(tokenId);
    Assert.equal(msg.sender,tokens.ownerOf(tokenId),"The owner of the token should now be msg.sender");
  }

  //create tokens from 2 different addresses and check the total tokens is equal to their sum
  function testTotalSupply() public {

    tokens.createTokens(msg.sender);
    tokens.createTokens(testAddress);
    Assert.equal(uint(200),tokens.totalSupply(),"There should be 200 total tokens");
  }


}
