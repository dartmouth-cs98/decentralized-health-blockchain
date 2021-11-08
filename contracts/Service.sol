pragma solidity >=0.4.25 <0.7.0;

// Service contract, combines patient, doctor, file contracts
// and handles higher-level functionality
contract Service {
    // Doctor Mappings
    mapping (address => doctor) internal doctors;
    mapping (address => mapping(address => uint)) internal doctorToPatient;

    // File mappings
    mapping (bytes32 => file) internal fileHashDict;

    // Patient mappings
    mapping (address => patient) internal patients; // dictionary of all patients
    mapping (address => mapping (address => uint)) internal patientToDoctor; // dictionary mapping patient to doctor
    mapping (address => mapping (bytes32 => uint)) internal patientToFile; // dictionary mapping patient to files

    // Doctor struct
    struct doctor {
        string name;
        string clinic;
        address addr;
        address[] patient_list;
    }

    // File struct
    struct file {
        string file_name;
        string record_type;
        address uploader;
        string contents;
    }

    // Patient struct
    struct patient {
        string name;
        uint8 age;
        address addr;
        bytes32[] files; // hashes of file that belong to this user for display purpose
        address[] doctor_list;
    }

    // Doctor methods:
    
    // check address is a valid doctor
    modifier checkDoctor(address addr) {
        doctor memory d = doctors[addr];
        require(d.addr > address(0x0));
        _;
    }

    // getter function for doctor's information
    function getDoctorInfo() public view checkDoctor(msg.sender) returns(string memory, address[] memory, address) {
        doctor memory d = doctors[msg.sender];
        return (d.name, d.patient_list, d.addr);
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

    // File methods:

    // method to test file contract
    function testFile(string memory _file_contents, string memory _file_name) public returns(bytes32, string memory){
        bytes32 file_hash = keccak256(abi.encodePacked(_file_contents));
        fileHashDict[file_hash] = file({file_name:_file_name,record_type:"blood test",uploader:address(0x0),contents:_file_contents});
        return (file_hash, "Blood Test 1");
    }

    // used for testing, get the hash of a file's contents
    function getFileHash(string memory file_contents) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(file_contents));
    }

    // used for testing, get a file's name from the hash dictionary
    function getFileName(bytes32 file_hash) public view checkFile(file_hash) returns (string memory) {
        return fileHashDict[file_hash].file_name;
    }

    // make sure a file actually exists
    modifier checkFile(bytes32 file_hash) {
        bytes memory file_check = bytes(fileHashDict[file_hash].file_name);
        require(file_check.length > 0);
        _;
    }

    // given a file hash, get the file's name, type, and uploader
    function getFileInfo(bytes32 file_hash) internal view checkFile(file_hash) returns(file memory) {
        return fileHashDict[file_hash];
    }

    // Patient methods
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
    function signupPatient(string memory _name, uint8 _age) public returns(string memory, uint8, address, bytes32[] memory, address[] memory) {
        // store msg.sender as a patient in memory
        patient memory p = patients[msg.sender];
        // make sure a patient with this addr doesn't already exist
        require(!(p.addr > address(0x0)));

        // check to make sure the patient has a valid name and age
        require(keccak256(abi.encodePacked(_name)) != keccak256(""));
        require((_age > 0) && (_age < 120));

        // add to patient dict
        patients[msg.sender] = patient({name:_name,age:_age,addr:msg.sender,files:new bytes32[](0),doctor_list:new address[](0)});
        return (patients[msg.sender].name, patients[msg.sender].age, patients[msg.sender].addr, patients[msg.sender].files, patients[msg.sender].doctor_list);
    }


    // Service methods

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
    function addFile(string memory _file_name, string memory _file_type, address _patient_addr, string memory _contents) public checkDoctor(msg.sender) {
        bytes32 file_hash = keccak256(abi.encode(_contents));
        // get the patient
        patient storage pat = patients[_patient_addr];

        // make sure the file doesn't already exist
        require(patientToFile[_patient_addr][file_hash] < 1);
      
        // add this file to the file hash dict and the patient's file list
        fileHashDict[file_hash] = file({file_name:_file_name, record_type:_file_type,uploader:msg.sender,contents:_contents});
        uint file_pos = pat.files.push(file_hash);
        // add the position in the file list to patientToFile mapping (avoid duplicates in future)
        patientToFile[_patient_addr][file_hash] = file_pos;
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