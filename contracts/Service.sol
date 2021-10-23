pragma solidity >=0.4.25 <0.7.0;

import "./Doctor.sol";
import "./Patient.sol";
import "./File.sol";

// Service contract, inherits from patient, doctor, file 
// and handles higher-level functionality
contract Service is Doctor, Patient, File {
	
    // message sender
    address private owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    // methods to implement: 
    // give access to a doctor, add a file, get patient/doctor info from a file?
    // want to have checks as well
}