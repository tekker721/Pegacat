pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/TokenMinting.sol";

/// @dev testing the functions to generate new tokens
/// @author Alex Koller & Kevin Le
contract testCreate{
  TokenMinting tokens = TokenMinting(DeployedAddresses.TokenMinting());
  address owner = msg.sender;
  uint tokenId = uint(keccak256("KEVIN07"));

  /// @dev testing the generation of 100 tokens
  function testCreateTokens()public {
    /// owner of tokens is msg.sender
    tokens.createTokens(msg.sender);
    /// checking that 100 tokens were actually generated
    Assert.equal(uint(100), tokens.totalSupply(), "There should be 100 tokens minted");
    ///Assert.equal(tokens.ownerOf(), msg.sender, "These should both be msg.sender");

    /// TODO: still need to check that the token ids were set correctly
    /// - were incremeneting at generation
  }

  /// @dev testing the generation of a single token
  function testCreateToken()public {
    /// creating a single token and storing the index of the token
    uint index = tokens.createToken(owner, tokenId);
    /// confirming that the totalSupply of tokens increased
    Assert.equal(uint(1), tokens.totalSupply()-100, "There should be 1 token minted");
    /// checking that the owner of the token is msg.sender
    Assert.equal(tokens.ownerOf(index), owner, "These should both be msg.sender");
  }

}
