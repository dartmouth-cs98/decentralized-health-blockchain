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

  // Doctor tests
  it('creates a new doctor by calling the signupDoctor method', async () => {
    // Wait for the contract to be deployed
    const doctorInstance = await Service.deployed();
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

  // Patient tests
  it('creates a new patient by calling the signupPatient method', async () => {
    // Wait for the contract to be deployed
    const patientInstance = await Service.deployed();
    // Call signupGreeting function
    const patient1 = await patientInstance.signupPatient('Dionysios Kotsonis', 12);
    // 
    console.log("======================");
    console.log(typeof(accounts[0]));
    assert.equal(patient1.receipt.from.toUpperCase(), accounts[0].toUpperCase());

    const p = await patientInstance.getPatientInfo();
    console.log(p);
    assert.equal(p[0], 'Dionysios Kotsonis');
    console.log(typeof(p[1]));
    assert.equal(p[2], 0);
}); 

  // File tests
  it('uses testFile method to check deployment of File.sol', async () => {
    
    // Wait for the contract to be deployed
    const fileInstance = await Service.deployed();
    // Call testFile function
    const tfile = await fileInstance.testFile("HIV: Negative|Hepatitus C: Negative|Coronavirus: Positive","blood test 1");
    // 
    console.log("======================");
    console.log(tfile)

    // get file hash, and file name from that
    const hash = await fileInstance.getFileHash("HIV: Negative|Hepatitus C: Negative|Coronavirus: Positive");
    const file_name = await fileInstance.getFileName(hash);
    
    // make sure the file name returns properly
    assert.equal(file_name,"blood test 1");
  });
});