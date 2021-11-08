const Doctor = artifacts.require("Doctor");

contract('Doctor', (accounts) => {
  // Test Doctor.sol contract
  it('creates a new doctor by calling the signupDoctor method', async () => {
    // Wait for the contract to be deployed
    const doctorInstance = await Doctor.deployed();
    // Call signupGreeting function
    const doctor1 = await doctorInstance.signupDoctor('Dionysios Kotsonis', "MGH Boston");
    // 
    console.log("======================");
    console.log(doctor1[0]);
    assert.equal(doctor1.receipt.from.toUpperCase(), accounts[0].toUpperCase());


    // get doctor info and make sure it's correct (check doctor name and empty patient list)
    const d = await doctorInstance.getDoctorInfo();
    console.log(d);
    assert.equal(d[0], 'Dionysios Kotsonis');
    console.log(typeof(d[1]));
    assert.equal(d[1], 0);
  });
});
