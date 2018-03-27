pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "./BaseContract.sol";

/// @title Ownership contract that deals with all of the ownership related
/// functionality of a token
/// @author Alex Koller & Kevin Le
/// lastmod 26/3/18
contract BaseOwnership is BaseContract, ERC721 {

  /// @dev Returns the number of tokens owned by the given ownerId
  function balanceOf(address _owner) public view returns (uint count) {
    return ownerTokenCount[_owner];
  }

  /// @dev The external function that transfers one token from its current
  /// owner id to a new id
  function transfer(address _to, uint256 _tokenId) external {
    /// check token has an owner (not 0x0)
    require(_to != address(0));
    /// check  that the owner to be is not already the owner
    require(_to != ownerOf(_tokenId));
    /// check that the owner of the token is msg.sender
    require(ownerOf(_tokenId) == msg.sender);

    /// TODO: use the approval class to do these checks (tidy up code)
    /// executing internal transfer function from base contract
    _transfer(msg.sender, _to, _tokenId);
  }


  //approve - to be implemented later
  /* function approve() internal {

  } */

  /* /// @dev transferfrom - logic to be checked
  function transferFrom(address _from, address _to, uint _tokenId) external {
    //check token has an owner (not 0x0)
    require(_to != address(0));
    //check  that the owner to be is not already the owner
    require(_to != address(_tokenId));
    //check that the owner of the token is msg.sender
    require(ownerOf(_tokenId) == _from);

    _transfer(_from, _to, _tokenId);

  } */


  /// @dev returns the total count of all tokens
  function totalSupply() public view returns(uint) {
    return tokens.length-1;
  }

  /// @dev returns the owner of a given token id
  function ownerOf(uint256 _tokenId) public view returns (address) {
    address owner = tokenIndex[_tokenId];
    require(owner != address(0));
    return owner;
  }
}
