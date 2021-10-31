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
    
    // methods to implement: 
    // give access to a doctor, add a file, get patient/doctor info from a file?
    // want to have checks as well

    // allow doctor to get info about a specific patient
    function getPatientInfoForDoctor(address _patient) public view checkPatient(_patient) checkDoctor(msg.sender) returns(string memory , uint8, address, bytes32[] memory ){
        patient memory p = patients[_patient];

        require(patientToDoctor[_patient][msg.sender] > 0);

        return (p.name, p.age, p.addr, p.files);
    }

    // add a file to a patient's list
    function addFile(string memory _file_name, string memory _file_type, bytes32 _file_hash, address _patient_addr, string memory _contents) public checkDoctor(msg.sender) {
        
        // get the patient
        patient storage pat = patients[_patient_addr];

        // make sure the file doesn't already exist
        require(patientToFile[_patient_addr][_file_hash] < 1);
      
        // add this file to the file hash dict and the patient's file list
        fileHashDict[_file_hash] = file({file_name:_file_name, file_type:_file_type,uploader:msg.sender,contents:_contents});
        uint file_pos = pat.files.push(_file_hash);
        // add the position in the file list to patientToFile mapping (avoid duplicates in future)
        patientToFile[_patient_addr][_file_hash] = file_pos;
    }
}