const Service = artifacts.require("Service");

contract('GetPatientInfoForDoctor', (accounts) => {

    // create doctor contract
    it('creates new service contract, creates doctor and patient, and tests test getPatientInfoForDoctor', async () => {
        // Wait for the contract to be deployed
        const serviceInstance = await Service.deployed();

        // sign up the doctor and patient
        const doctor = await serviceInstance.signupDoctor('Dionysios Kotsonis', 'MGH Boston');
        const patient = await serviceInstance.signupPatient('Kevin Cai', 12);
        console.log("=========DOCTOR=======")
        console.log(doctor);
        
        // call getPatientInforForDoctor function
        const doctorInfo = await serviceInstance.getDoctorInfoForPatient(doctor.receipt.from);
        console.log("=======DOCTOR INFO======");
        console.log(doctorInfo);
        assert.equal(doctorInfo[0], "Dionysios Kotsonis");
        assert.equal(doctorInfo[1], 'MGH Boston');
    });
});