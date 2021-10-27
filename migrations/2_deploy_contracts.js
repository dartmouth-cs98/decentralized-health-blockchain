const ConvertLib = artifacts.require("ConvertLib");
const HelloWorld = artifacts.require("HelloWorld");
const Patient = artifacts.require("Patient");
const Doctor = artifacts.require("Doctor");
const File = artifacts.require("File");
const Service = artifacts.require("Service");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, HelloWorld);
  deployer.deploy(HelloWorld);
  deployer.deploy(Patient);
  deployer.deploy(Doctor);
  deployer.deploy(File);
  deployer.deploy(Service);
};
