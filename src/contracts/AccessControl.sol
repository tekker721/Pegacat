pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/token/ERC721/ERC721.sol";

contract AccessControl {

  // The addresses of the accounts (or contracts) that can execute actions within each roles.
  address public ceoAddress;
  address public cfoAddress;
  address public cooAddress;

  /// @dev Access modifier for CEO-only functionality
  modifier onlyCEO() {
      require(msg.sender == ceoAddress);
      _;
  }

  /// @dev Access modifier for CFO-only functionality
  modifier onlyCFO() {
      require(msg.sender == cfoAddress);
      _;
  }

  /// @dev Access modifier for COO-only functionality
  modifier onlyCOO() {
      require(msg.sender == cooAddress);
      _;
  }

  /// @dev Assigns a new address to act as the CEO. Only available to the current CEO.
  /// @param _newCEO The address of the new CEO
  /// NOTE: CURRENTLY NO CEO SPECIFIED FOR TESTING PURPOSES
  function setCEO(address _newCEO) external {
      require(_newCEO != address(0));

      ceoAddress = _newCEO;
  }

  /// @dev Assigns a new address to act as the CFO. Only available to the current CEO.
  /// @param _newCFO The address of the new CFO
  function setCFO(address _newCFO) external onlyCEO {
      require(_newCFO != address(0));

      cfoAddress = _newCFO;
  }

  /// @dev Assigns a new address to act as the COO. Only available to the current CEO.
  /// @param _newCOO The address of the new COO
  function setCOO(address _newCOO) external onlyCEO {
      require(_newCOO != address(0));

      cooAddress = _newCOO;
  }




}
