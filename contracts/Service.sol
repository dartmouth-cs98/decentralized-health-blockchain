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
    
    // methods to implement: 
    // give access to a doctor, add a file, get patient/doctor info from a file?
    // want to have checks as well

    // allow doctor to get info about a specific patient
    function getPatientInfoForDoctor(address patient) public view checkPatient(patient) checkDoctor(msg.sender) returns(string memory , uint8, address, bytes32[] memory ){
        patient memory p = patients[patient];

        require(patientToDoctor[patient][msg.sender] > 0);

        return (p.name, p.age, p.addr, p.files);
    }
}