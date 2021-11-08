const Service = artifacts.require("Service");

contract('GetDoctorInfoForPatient', (accounts) => {

    // create doctor contract
    it('creates new service contract, creates doctor and patient, and tests test getPatientInfoForDoctor', async () => {
        // Wait for the contract to be deployed
        const serviceInstance = await Service.deployed();

        // sign up the doctor and patient
        const doctor = await serviceInstance.signupDoctor('Dionysios Kotsonis', 'MGH Boston');
        const patient = await serviceInstance.signupPatient('Kevin Cai', 12);
        console.log("=========DOCTOR=======")
        console.log(doctor);

        // get doctor info
        const d = await serviceInstance.getDoctorInfo();

        // give patient access to this doctor
        const x = await serviceInstance.grantDoctorAccess(d[2]);
        
        // call getPatientInforForDoctor function
        const doctorInfo = await serviceInstance.getDoctorInfoForPatient(d[2]);
        console.log("=======DOCTOR INFO======");
        console.log(doctorInfo);
        assert.equal(doctorInfo[0], "Dionysios Kotsonis");
        assert.equal(doctorInfo[1], 'MGH Boston');
    });
});