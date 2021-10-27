const Service = artifacts.require("Service");

contract('Service', (accounts) => {
  // Test Service.sol contract
  it('creates a new service instance by calling the testService method', async () => {
    // Wait for the contract to be deployed
    const serviceInstance = await Service.deployed();
    // Call testService function
    const tservice = await serviceInstance.testService();
    // 
    console.log("======================");
    console.log(typeof(accounts[0]));
    console.log(tservice);
    assert.equal(tservice.toUpperCase(), accounts[0].toUpperCase());
  });
});