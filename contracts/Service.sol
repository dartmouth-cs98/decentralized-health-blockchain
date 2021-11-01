pragma solidity >=0.4.25 <0.7.0;

import "./Doctor.sol";
import "./Patient.sol";
import "./File.sol";

// Service contract, inherits from patient, doctor, file 
// and handles higher-level functionality
contract Service is Doctor, Patient, File {
	
    // message sender
    address private owner;
    
    // set owner
    constructor() public{
        owner = msg.sender;
    }

    // make sure that the sender is the owner
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function testService() public view returns(address){
        return msg.sender;
    }

    // add a file to a patient's list
    function addFile(string memory _file_name, string memory _file_type, bytes32 _file_hash, address _patient_addr, string memory _contents) public checkDoctor(msg.sender) {
        
        // get the patient
        patient storage pat = patients[_patient_addr];

        // make sure the file doesn't already exist
        require(patientToFile[_patient_addr][_file_hash] < 1);
      
        // add this file to the file hash dict and the patient's file list
        fileHashDict[_file_hash] = file({file_name:_file_name, record_type:_file_type,uploader:msg.sender,contents:_contents});
        uint file_pos = pat.files.push(_file_hash);
        // add the position in the file list to patientToFile mapping (avoid duplicates in future)
        patientToFile[_patient_addr][_file_hash] = file_pos;
    }

    // method to grant a doctor access to a patient's record
    function grantDoctorAccess(address _doctor_address) public checkPatient(msg.sender) checkDoctor(msg.sender) {
        // get struct for patient and doctor
        patient storage p = patients[msg.sender];
        doctor storage d = doctors[_doctor_address];
        // check doctor does not already have access
        require(patientToDoctor[msg.sender][_doctor_address] < 1);// this means doctor already been access
        // get the index of doctor's position in patient's doctor_list
        uint idx = p.doctor_list.push(_doctor_address);// new length of array
        // add doctor to patient's doctor list
        patientToDoctor[msg.sender][_doctor_address] = idx;
        // add patient to doctor's patient list
        d.patient_list.push(msg.sender);
    }

    // function to get patient info (a doctor requests)
    function getPatientInfoForDoctor(address _patient_requested) public view checkPatient(_patient_requested) checkDoctor(msg.sender) returns(string memory, uint8, bytes32[] memory){
        
        // get the patient from the patient list
        patient memory p = patients[_patient_requested];

        // make sure the patient actually exists in this doctor's care circle
        require(patientToDoctor[_patient_requested][msg.sender] > 0);

        // return the patient's name, age, and files
        return (p.name, p.age, p.files);
    }

    // function to get doctor info (for a patient) -- will see how necessary this ends up being
    function getDoctorInfoForPatient(address _doctor_requested) public view checkPatient(msg.sender) checkDoctor(_doctor_requested) returns(string memory, string memory){
        
        // get the doctor from the doctors list
        doctor memory d = doctors[_doctor_requested];

        // make sure the doctor actually exists
        require(doctorToPatient[_doctor_requested][msg.sender] > 0);

        return (d.name, d.clinic);
    }
}