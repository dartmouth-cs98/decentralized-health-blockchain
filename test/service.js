const Service = artifacts.require("Service");

contract('Service', (accounts) => {
  // Test Service.sol contract
  it('creates a new service instance by calling the testService method', async () => {
    // Wait for the contract to be deployed
    const serviceInstance = await Service.deployed();
    // Call testService function
    const tservice = await fileInstance.testFile();
    // 
    console.log("======================");
    console.log(typeof(accounts[0]));
    assert.equal(tfile.receipt.from.toUpperCase(), accounts[0].toUpperCase());
  });
});