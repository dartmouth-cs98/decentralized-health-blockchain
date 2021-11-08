const Service = artifacts.require("Service");

contract('GetPatientInfoForDoctor', (accounts) => {

    // create doctor contract
    it('creates new service contract, creates doctor and patient, and tests test getPatientInfoForDoctor', async () => {
        // Wait for the contract to be deployed
        const serviceInstance = await Service.deployed();

        // sign up the doctor and patient
        const doctor = await serviceInstance.signupDoctor('Dionysios Kotsonis', 'MGH Boston');
        const patient = await serviceInstance.signupPatient('Kevin Cai', 12);
        console.log("=========PATIENT=======")
        console.log(patient)
        
        // call getPatientInforForDoctor function
        const patientInfo = await serviceInstance.getPatientInfoForDoctor(patient.receipt.from);
        console.log("=======PATIENT INFO======");
        console.log(patientInfo);
        assert.equal(patientInfo[0], "Kevin Cai");
        assert.equal(patientInfo[1], 12);
        assert.equal(patientInfo[2], []);
    });
});