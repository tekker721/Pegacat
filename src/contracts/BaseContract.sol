pragma solidity ^0.4.18;

/// @title Base contract that holds all common structs, events and base variables.
/// @author Alex Koller & Kevin Le
/// lastmod 26/3/18

contract BaseContract {

  /// @dev Event that is triggered each time the ownership of a token changes
  event Transfer(address from, address to, uint256 tokenId);

  // @dev General blank struct for basic token. Currently has no other necessary data
  struct BaseToken {
    uint256 id;
  }

  /// @dev An array to store all tokens that exist (have been minted). The array
  /// is made up of BaseToken structs
  BaseToken[] tokens;

  /// @dev Maps the index of a token in the array to the address of the owner
  /// All tokens have an owner, even if it is a O address
  /// TODO: refactor to better naming?
  mapping (uint256 => address) public tokenIndex;

  /// @dev Mapping an address to the number of tokens owned by the address
  mapping (address => uint256) ownerTokenCount;

  /// @dev Mapping tokenid to an address that is approved to transfer the token
  /// @dev Each token can only have one address in this Mapping
  /// @dev If there is no tokenid mapping, there is no approval for transfer
  mapping (uint => address) tokenApprovals;

  /// TODO: implment the rest of the ERC721 functions to be compliant
  /// especially understand approval()

  /// @dev This function transfers the ownership of a given token to a new address
  /// Note: this is the internal function
  /// @param _from are valid addresses
  /// @param _to are valid addresses
  /// @param _tokenId is a valid, exisiting token
  function _transfer(address _from, address _to, uint256 _tokenId) internal {
    /// update count of new owners tokens
    ownerTokenCount[_to]++;
    /// update owner of token in mapping
    tokenIndex[_tokenId] = _to;

    /// if this is not a new token (ie address is not 0)
    if (_from != address(0)){
      /// decrease the count of tokens the old owner has
      ownerTokenCount[_from]--;
    }
    ///depreciation
    /// trigger the transfer event
    Transfer(_from, _to, _tokenId);
  }

  /// @dev This function generates a new token and stores is
  /// @param _id is a unique token id
  /// @param _owner is a valid address
  function _generateToken(uint256 _id, address _owner) internal returns (uint) {
    /// create token
    BaseToken memory _tempToken = BaseToken({ id: _id });
    /// add the token to the array of all tokens
    uint256 tempTokenIndex = tokens.push(_tempToken) -1;
    /// ensuring there is no overflow
    require(tempTokenIndex == uint256(uint32(tempTokenIndex)));
    /// transfer the owner of the token from a 0 address to given addresses
    _transfer(0, _owner, tempTokenIndex);
    /// return the index of the token in the tokens array
    return tempTokenIndex;
  }

}
