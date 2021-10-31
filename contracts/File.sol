pragma solidity >=0.4.25 <0.7.0;

// File contract
contract File {

    mapping (bytes32 => file) internal fileHashDict;
    
    struct file {
        string file_name;
        string record_type;
        address uploader;
        string contents;
    }

    // method to test file contract
    function testFile(string memory _file_contents, string memory _file_name, string memory _contents) public returns(bytes32, string memory){
        bytes32 file_hash = keccak256(abi.encodePacked(_file_contents));
        fileHashDict[file_hash] = file({file_name:_file_name,record_type:"blood test",uploader:address(0x0),contents:_contents});
        return (file_hash, "Blood Test 1");
    }

    // used for testing, get the hash of a file's contents
    function getFileHash(string memory file_contents) public view returns (bytes32) {
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
}