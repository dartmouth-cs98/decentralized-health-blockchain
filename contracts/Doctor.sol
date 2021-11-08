pragma solidity >=0.4.25 <0.7.0;
//pragma experimental ABIEncoderV2;

// Doctor contract
contract Doctor {
    mapping (address => doctor) internal doctors;
    mapping (address => mapping(address => uint)) internal doctorToPatient;
    
    // may need more variables (will see when fleshing out secondary features)
    struct doctor {
        string name;
        string clinic;
        address addr;
        address[] patient_list;
    }

    // check address is a valid doctor
    modifier checkDoctor(address addr) {
        doctor memory d = doctors[addr];
        require(d.addr > address(0x0));
        _;
    }

    // getter function for doctor's information
    function getDoctorInfo() public view checkDoctor(msg.sender) returns(string memory, address[] memory, address, string memory) {
        doctor memory d = doctors[msg.sender];
        return (d.name, d.patient_list, d.addr, d.clinic);
    }

    // Create a new doctor method
    function signupDoctor(string memory _name, string memory _clinic) public returns(string memory, address, address[] memory, string memory) {
        
        // get doctor struct, make sure the name, clinic, and address exist
        doctor memory d = doctors[msg.sender];
        require(keccak256(abi.encodePacked(_name)) != keccak256(""));
        require(keccak256(abi.encodePacked(_clinic)) != keccak256(""));
        require(!(d.addr > address(0x0)));

        // create doctor structure, return saved info
        doctors[msg.sender] = doctor({name:_name, clinic:_clinic, addr:msg.sender, patient_list:new address[](0)});
        return (doctors[msg.sender].name, doctors[msg.sender].addr, doctors[msg.sender].patient_list, doctors[msg.sender].clinic);
    }    
}