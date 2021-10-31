pragma solidity >=0.4.25 <0.7.0;

// File contract
contract File {

    mapping (bytes32 => file) internal fileHashDict;
    
    struct file {
        string file_name;
        string record_type;
        address uploader;
    }

    // method to test file contract
    function testFile(string memory _file_contents, string memory _file_name) public returns(bytes32, string memory){
        // return ("blood test 1", "blood test",new address[](0));
        bytes32 file_hash = keccak256(abi.encodePacked(_file_contents));
        fileHashDict[file_hash] = file({file_name:_file_name,record_type:"blood test",uploader: address(0x0)});
        return (file_hash, "Blood Test 1");
        // fileHashDict[msg.sender] = file({name:_n, addr:msg.sender, patient_list:new address[](0)});
    }

    function getFileHash(string memory file_contents) public view returns (bytes32) {
        return keccak256(abi.encodePacked(file_contents));
    }

    function getFileName(bytes32 file_hash) public view checkFile(file_hash) returns (string memory) {
        return fileHashDict[file_hash].file_name;
    }

    // make sure a file actually exists
    modifier checkFile(bytes32 file_hash) {
        bytes memory file_check = bytes(fileHashDict[file_hash].file_name);
        require(file_check.length > 0);
        _;
    }

    // given a file hash, 
    function getFileInfo(bytes32 file_hash) internal view checkFile(file_hash) returns(file memory) {
        return fileHashDict[file_hash];
    }
}