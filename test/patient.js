// const Patient = artifacts.require("Patient");

// contract('Patient', (accounts) => {
//     // Test Patient.sol contract
//     it('creates a new patient by calling the signupPatient method', async () => {
//         // Wait for the contract to be deployed
//         const patientInstance = await Patient.deployed();
//         // Call signupGreeting function
//         const patient1 = await patientInstance.signupPatient('Dionysios Kotsonis', 12);
//         // 
//         console.log("======================");
//         console.log(typeof(accounts[0]));
//         assert.equal(patient1.receipt.from.toUpperCase(), accounts[0].toUpperCase());

//         const p = await patientInstance.getPatientInfo();
//         console.log(p);
//         assert.equal(p[0], 'Dionysios Kotsonis');
//         console.log(typeof(p[1]));
//         assert.equal(p[2], 0);
//     }); 
// });
