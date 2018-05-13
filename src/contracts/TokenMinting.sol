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


  /// @dev purchase a token and transfer it to the purchaser
  function purchaseToken(uint256 tokenId) public payable {

    address owner = tokenIndex[tokenId];
    require(owner != msg.sender); //require that the owner is not the buyer
    require(msg.sender != address(0));
    require(msg.value == price);

    owner.transfer(price);
/*
    if (owner == address(this)){//if the owner of the token is this contract address
        ceoAddress.transfer(price);
    } else {//otherwise transfer the ether to the owner of the token
      owner.transfer(price);
    }
*/
    _approve(msg.sender, tokenId);

  }
}
