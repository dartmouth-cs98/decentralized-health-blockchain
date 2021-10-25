const Patient = artifacts.require("Patient");

contract('Patient', (accounts) => {
//   // Test Patient.sol contract
  it('testPatient file should initialize mock patient', async () => {
    // Wait for the contract to be deployed
    const patientInstance = await Patient.deployed();
    // Call getGreeting function
    const p = await patientInstance.testPatient();
    // Check the value is initialized.
    assert.equal(p.name, "bob", "Patient incorrectly initialized.");
  });
});
