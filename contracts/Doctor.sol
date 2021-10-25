pragma solidity >=0.4.25 <0.7.0;
//pragma experimental ABIEncoderV2;

// Doctor contract
contract Doctor {
    mapping (address => doctor) internal doctors;
    mapping (address => mapping(address => uint)) internal doctorToPatient;
    
    struct doctor {
        string name;
        address addr;
        address[] patient_list;
    }
    
    // // test method for doctor class
    // function testDoctor() public view returns(doctor memory){
	// 	return doctor({name:"Dionysios Kotsonis",addr:address(0x0),patient_list:new address[](0)});
	// }

    // check address is a valid doctor
    modifier checkDoctor(address addr) {
        doctor memory d = doctors[addr];
        require(d.addr > address(0x0));
        _;
    }

    // getter function for doctor's information
    function getDoctorInfo() public view checkDoctor(msg.sender) returns(string memory, address[] memory) {
        doctor memory d = doctors[msg.sender];
        return (d.name, d.patient_list);
    }

    // Create a new doctor method
    function signupDoctor(string memory _name) public returns(string memory, address, address[] memory) {
        doctor memory d = doctors[msg.sender];
        require(keccak256(abi.encodePacked(_name)) != keccak256(""));
        require(!(d.addr > address(0x0)));

        doctors[msg.sender] = doctor({name:_name, addr:msg.sender, patient_list:new address[](0)});
        return (doctors[msg.sender].name, doctors[msg.sender].addr, doctors[msg.sender].patient_list);
    }    
}