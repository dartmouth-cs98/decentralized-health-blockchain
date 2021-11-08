const ConvertLib = artifacts.require("ConvertLib");
const Service = artifacts.require("Service");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.deploy(Service);
};