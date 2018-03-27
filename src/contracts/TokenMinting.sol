pragma solidity ^0.4.18;

import "./BaseOwnership.sol";

/// @title Miniting contract deals with the generation of new tokens
/// @author Alex Koller & Kevin Le
/// lastmod 27/3/18
contract TokenMinting is BaseOwnership {
  /// constant used for limit on how many tokens to mint
  uint256 public constant LIMIT = 100;

  /// @dev creates an individual token
  function createToken(address _owner, uint256 _tokenId) public returns(uint) {
    return _generateToken(_tokenId, _owner);
  }

  /// @dev generates multiple tokens
  function createTokens(address owner) public {
    for (uint256 i = 0; i <= LIMIT; i++){
      createToken(owner, i);
    }
  }
}
