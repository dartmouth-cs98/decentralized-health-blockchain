const ConvertLib = artifacts.require("ConvertLib");
const HelloWorld = artifacts.require("HelloWorld");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, HelloWorld);
  deployer.deploy(HelloWorld);
};
