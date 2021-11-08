// const Service = artifacts.require("Service");
// const Patient = artifacts.require("Patient");
// const Doctor = artifacts.require("Doctor");

// contract('TestAccess', (accounts) => {

//     // create doctor contract
//     it('creates new patient, doctor, service contracts, test get access', async () => {
//         // Wait for the contracts to be deployed
//         const doctorInstance = await Doctor.deployed();
//         const patientInstance = await Patient.deployed();
//         const serviceInstance = await Service.deployed();
//         // sign up the doctor
//         const doctor = await doctorInstance.signupDoctor('Dionysios Kotsonis', 'MGH Boston');
//         const patient = await patientInstance.signupPatient('Kevin Cai', 12);
//         // 
//         console.log("======================");
//         console.log(doctor);
//         assert.equal(patient.receipt.from.toUpperCase(), accounts[0].toUpperCase());

//         // get doctor info and make sure it's correct (check doctor name and empty patient list)
//         const d = await doctorInstance.getDoctorInfo();
//         const p = await patientInstance.getPatientInfo();

//         console.log("doctor address:")
//         console.log(d[2]);
//         console.log("patient:")
//         console.log(p)

//         const x = await serviceInstance.grant(d[2]);
//         console.log("x above");
//         console.log(x);
//         console.log("x below");

//     });
//     // Test Service.sol contract
//     it('creates a new service instance by calling the testService method', async () => {
//         // Wait for the contract to be deployed
//         const serviceInstance = await Service.deployed();
//         // Call testService function
//         const tservice = await serviceInstance.testService();
//         // 
//         console.log("======================");
//         console.log(typeof(accounts[0]));
//         console.log(tservice);
//         assert.equal(tservice.toUpperCase(), accounts[0].toUpperCase());
//     });
// });