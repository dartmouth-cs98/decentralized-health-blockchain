const Service = artifacts.require("Service");

module.exports = function(deployer) {
  deployer.deploy(Service);
};