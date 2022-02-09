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
        console.log("New patient structure with doctor access:");
        console.log(p1);
        console.log(p1[3]);

        const rev = await serviceInstance.revokeDoctorAccess(d[2]);

        const atr = await serviceInstance.checkRevokeAccess.call(d[2]);
        console.log("PatientToDoctor after revoking access")
        console.log(atr);

        // check the doctor from this patient
        const doct = await serviceInstance.getDoctorInfoForPatient(d[2])
        console.log(doct)

        const x1 = await serviceInstance.grantDoctorAccess(d[2]);
        const p2 = await serviceInstance.getPatientInfo();
        console.log(p2)
        const atr1 = await serviceInstance.checkRevokeAccess.call(d[2]);
        console.log(atr1)
    });
});