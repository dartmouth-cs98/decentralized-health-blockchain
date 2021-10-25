const Patient = artifacts.require("Patient");

contract('Patient', (accounts) => {
//   // Test Patient.sol contract
  it('creates a new patient by calling the signupPatient method', async () => {
    // Wait for the contract to be deployed
    const patientInstance = await Patient.deployed();
    // Call getGreeting function
    const patient1 = await patientInstance.signupPatient('Dionysios Kotsonis',12);
    // 
    console.log("=================");
    console.log(typeof(accounts[0]))
    assert.equal(patient1.receipt.from.toUpperCase(), accounts[0].toUpperCase());
  });
});
