pragma solidity ^0.4.18;

import "./BaseOwnership.sol";

/// @title Basic marketplace logic
/// to be expanded on
/// @author Patrick Guo
/// lastmod 22/6/18

contract TokenSales is BaseOwnership {

  struct Sale {
    //have a unique sale id? gets rid of same token problem
    address seller;
    uint256 tokenId;
    uint256 price;
  }
  //SOLIDITY DOES NOT SUPPORT DECIMAL/FLOAT/DOUBLE

  uint256 internal houseCut = 3;//set cut of trade price to keep on this contract address. the integer represents the percentage of the cut

  mapping (uint256 => Sale) tokenIdToSale;

/*
  function setCut(uint256 cut) onlyMasterAddress {
    houseCut = cut;
  }
*/

  /// @dev Creates a sale
  function createSale(uint256 tokenId, uint256 price) public onlyOwnerOf(tokenId) {
    Sale memory sale = Sale(msg.sender, tokenId, price);//Create sale struct
    tokenIdToSale[tokenId] = sale;//create a new mapping
    _approve(this, tokenId);//approves this contract to take ownership of the token
    _escrow(msg.sender, tokenId);//escrows the token to this contract
  }

  /// @dev Remove a sale
  function cancelSale(uint256 tokenId) public {
    Sale sale = tokenIdToSale[tokenId];
    require(sale.seller == msg.sender);//check that the seller listed is the actual seller
    delete(tokenIdToSale[tokenId]);//remove sale from mapping
    _approve(msg.sender, tokenId);//approves the token to be sent back to seller
    _transfer(this, msg.sender, tokenId);//token is transferred back to seller
  }

  /// @dev Escrows the token, assigning ownership to this contract.
  /// Throws if the escrow fails.
  /// @param _owner - Current owner address of token to escrow.
  /// @param _tokenId - ID of token whose approval to verify.
  function _escrow(address _owner, uint256 _tokenId) internal {
      // it will throw if transfer fails
      /* transferFrom(_owner, this, _tokenId); */
      takeOwnership(_tokenId);
  }

  /// @dev purchase a token and transfer it to the purchaser
  function purchaseToken(uint256 tokenId) public payable {
    Sale sale = tokenIdToSale[tokenId];
    address seller = sale.seller;
    require(msg.sender != sale.seller); //require that the owner is not the buyer
    require(msg.sender != address(0));
    require(msg.value == sale.price); //check that the price is correct
    uint256 cut = calcCut(sale.price);
    uint256 finalSaleValue = sale.price - cut;
    seller.transfer(finalSaleValue); //transfers the ether to the owner after house cut
    _approve(msg.sender, tokenId); //approves the token to be sent to the buyer
    _transfer(this, msg.sender, tokenId); //send token to buyer
    delete(tokenIdToSale[tokenId]);//remove sale from mapping
  }

  /// @dev calculates the cut that we receive from each transaction on the marketplace
  function calcCut(uint256 price) internal view returns (uint256) {
    require(houseCut<100);
    return price * houseCut/100;//calculates the percentage that we keep from the trade
  }

/*
  /// @dev withdraws the ether held in this contract to a master wallet
  function withdrawBalance() onlyMasterAddress {
    msg.sender.transfer(this.balance);
  }
*/
}
