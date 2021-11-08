const Service = artifacts.require("Service");

contract('AddFile', (accounts) => {

    // create service contract
    it('creates new service contract, creates doctor and patient, and tests addfile', async () => {
        // Wait for the contract to be deployed
        const serviceInstance = await Service.deployed();

        // sign up the doctor and patient
        const doctor = await serviceInstance.signupDoctor('Dionysios Kotsonis', 'MGH Boston');
        const patient = await serviceInstance.signupPatient('Kevin Cai', 12);
        console.log("=========DOCTOR=======")
        console.log(doctor);

        // give patient access to this doctor
        const x = await serviceInstance.grantDoctorAccess(doctor.receipt.from);
        
        // file contents
        const contents = "Blood Test 1 | Ailment {Hepatitus C, HIV} | Presence {Negative, Positive}";
        // file contents hash (for testing)
        const hash = '0x361ea7bb324d1dab4d4c266ae4d7eb8281f45f7e794775346d87ee7e6c4ed3d1'

        // call addFile function
        const y = await serviceInstance.addFile("Blood Test 1", "Blood Test", patient.receipt.from, contents);
        // console.log("=======PATIENT INFO======");
        const patientInfo = await serviceInstance.getPatientInfo();
        console.log(patientInfo);
        assert.equal(patientInfo[2][0], hash);

        const file_name = await serviceInstance.getFileName(hash);
        console.log(file_name);
        assert.equal(file_name, "Blood Test 1");
        // assert.equal(patientInfo[2], 0);
    });
});