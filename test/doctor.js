const Doctor = artifacts.require("Doctor");

contract('Doctor', (accounts) => {
  // Test Doctor.sol contract
  it('creates a new doctor by calling the signupDoctor method', async () => {
    // Wait for the contract to be deployed
    const doctorInstance = await Doctor.deployed();
    // Call signupGreeting function
    const doctor1 = await doctorInstance.signupDoctor('Dionysios Kotsonis');
    // 
    console.log("======================");
    console.log(typeof(accounts[0]));
    assert.equal(doctor1.receipt.from.toUpperCase(), accounts[0].toUpperCase());
  });
});
