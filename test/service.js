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

  it('tests addFile method creates a new file in patients files array', async () => {
    const serviceInstance = await Service.deployed();
    console.log("1");
    // create patient instance
    const p = await serviceInstance.signupPatient("Dionysios Kotsonis", 12);
    console.log("2");
    // create doctor instance
    const d = await serviceInstance.signupDoctor("Kevin Cai", 21);
    console.log("3");
    // add file to patient's file list
    const f = await serviceInstance.addFile("Blood Test 1", "Blood Test", );
    console.log("4");
  });
});