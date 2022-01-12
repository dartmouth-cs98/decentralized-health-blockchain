const Service = artifacts.require("Service");

contract('TestAccess', (accounts) => {

    // create doctor contract
    it('creates new service contract, creates doctor and patient, and tests grantDoctorAccess and revokeDoctorAccess', async () => {
        // Wait for the contract to be deployed
        const serviceInstance = await Service.deployed();
        
        // sign up the doctor and patient
        const doctor = await serviceInstance.signupDoctor('Dionysios Kotsonis', 'MGH Boston');
        const patient = await serviceInstance.signupPatient('Kevin Cai', 12);
        // 
        console.log("======================");
        console.log(doctor);
        console.log(patient);
        assert.equal(patient.receipt.from.toUpperCase(), accounts[0].toUpperCase());

        // get doctor info and make sure it's correct (check doctor name and empty patient list)
        const d = await serviceInstance.getDoctorInfo();
        const p = await serviceInstance.getPatientInfo();

        console.log("doctor address:");
        console.log(d[2]);
        console.log("patient:");
        console.log(p);

        const x = await serviceInstance.grantDoctorAccess(d[2]);

        const p1 = await serviceInstance.getPatientInfo();
        console.log("New patient structure with doctor access:")
        console.log(p1);
        console.log(p1[3])

        // check that the doctor's address was added to the patient's doctor list
        assert.equal(p1[3][0], d[2]);

        // revoke access and make sure the doctor and patient lists are both empty
        const y = await serviceInstance.revokeDoctorAccess(d[2])
        const doct = await serviceInstance.getDoctorInfo();
        const pat = await serviceInstance.getPatientInfo();

        console.log("doctor:");
        console.log(doct);
        console.log("patient:");
        console.log(pat);

    });
});