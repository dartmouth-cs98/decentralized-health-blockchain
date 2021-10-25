pragma solidity >=0.4.25 <0.7.0;

// CONSIDERATION: DO WE WANT TO HAVE PATIENTS UNDER SPECIFIC INSTITUTIONS?

contract Patient {

    mapping (address => patient) internal patients; // dictionary of all patients
    mapping (address => mapping (address => uint)) internal patientToDoctor; // dictionary mapping patient to doctor
    mapping (address => mapping (bytes32 => uint)) internal patientToFile; // dictionary mapping patient to files
    
    struct patient {
        string name;
        uint8 age;
        address addr;
        bytes32[] files; // hashes of file that belong to this user for display purpose
        address[] doctor_list;
    }

    // check that a given patient actually exists
    modifier checkPatient(address addr) {
        patient memory p = patients[addr];
        require(p.addr > address(0x0));
        _;
    }

    // get info for a given patient (name, age, files, list of whitelisted doctors)
    function getPatientInfo() public view checkPatient(msg.sender) returns(string memory, uint8, bytes32[] memory, address[] memory) {
        patient memory p = patients[msg.sender];
        return (p.name, p.age, p.files, p.doctor_list);
    }

    // add a new patient
    function signupPatient(string memory _name, uint8 _age) public {

        // make sure a patient with this addr doesn't already exist
        patient memory p = patients[msg.sender];
        require(!(p.addr > address(0x0)));

        // check to make sure the patient has a valid name and age
        require(keccak256(abi.encodePacked(_name)) != keccak256(""));
        require((_age > 0) && (_age < 120));

        // add to patient dict
        patients[msg.sender] = patient({name:_name,age:_age,addr:msg.sender,files:new bytes32[](0),doctor_list:new address[](0)});
    }
}