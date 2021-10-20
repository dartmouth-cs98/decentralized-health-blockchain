pragma solidity >=0.4.25 <0.7.0;

contract Patient {
	mapping (address => patient) internal patients;
    mapping (address => mapping (address => uint)) internal patientToDoctor;
    mapping (address => mapping (bytes32 => uint)) internal patientToFile;
    
    struct patient {
        string name;
        uint8 age;
        address id;
        bytes32[] files;// hashes of file that belong to this user for display purpose
        address[]  doctor_list;
    }
}