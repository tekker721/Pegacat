var TokenMinting = artifacts.require("./TokenMinting.sol");
var BaseOwnership = artifacts.require("./BaseOwnership.sol");
var BaseContract = artifacts.require("./BaseContract.sol");

module.exports = function(deployer){
  deployer.deploy(BaseContract);
  deployer.deploy(TokenMinting);
  deployer.deploy(BaseOwnership);

};
