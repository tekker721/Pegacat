pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "./BaseContract.sol";


/// @title Ownership contract that deals with all of the ownership related
/// functionality of a token
/// @author Alex Koller & Kevin Le
/// lastmod 25/4/18

contract BaseOwnership is BaseContract, ERC721 {

  /// @dev Returns the number of tokens owned by the given ownerId
  function balanceOf(address _owner) public view returns (uint count) {
    return ownerTokenCount[_owner];
  }

  /// @dev The external function that transfers one token from its current
  /// owner id to a new id
  /// @dev have not cleared the token approval mapping - perhaps TODO: ?
  function transfer(
    address _to,
    uint256 _tokenId
    )
    external
    isApproved(msg.sender, _to, _tokenId)
    {
    /// executing internal transfer function from base contract
    _transfer(msg.sender, _to, _tokenId);
  }

  /// @dev approves an address for the specified token to be sent to
  function approve(
    address _to,
    uint256 _tokenId
    ) external
    onlyOwnerOf(_tokenId)
    {
    ///tokenApprovals[_tokenId] = _to;
    require(tokenIndex[_tokenId] == msg.sender);
    _approve(_to, _tokenId);
    Approval(msg.sender, _to, _tokenId);
  }

  /// @dev transfers a token to an approved address
  function transferFrom(
    address _from,
    address _to,
    uint256 _tokenId
    )
    external
    isApproved(_from, _to, _tokenId)
    {
    /// all security checks done in modifers
    _transfer(_from, _to, _tokenId);
  }

  /// @dev Claims the ownership of a given token ID
  function takeOwnership(uint256 _tokenId) public {
    require(tokenApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }

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

  function _approve(address _approved, uint256 _tokenId) internal {
        tokenApprovals[_tokenId] = _approved;
    }

  /// @dev Guarantees msg.sender is owner of the given token
  /// @param _tokenId uint256 ID of the token to validate its ownership belongs to msg.sender
  modifier onlyOwnerOf(uint256 _tokenId) {
    require(ownerOf(_tokenId) == msg.sender);
    _;
  }

  modifier isApproved(address _from, address _to, uint256 _tokenId) {
    /// check token has an owner (not 0x0)
    require(_to != address(0));
    /// check  that the owner to be is not already the owner
    require(_to != ownerOf(_tokenId));
    /// check that the owner of the token is _from
    require(ownerOf(_tokenId) == _from);
    /// checking for approval of the transfer
    require(tokenApprovals[_tokenId] == _to);
    _;
  }
}
