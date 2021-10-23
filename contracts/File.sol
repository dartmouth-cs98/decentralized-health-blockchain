pragma solidity >=0.4.25 <0.7.0;

// File contract
contract File {

    mapping (bytes32 => file) internal fileHashDict;
    
    struct file {
        string file_name;
        string record_type;
        address uploader;
    }

    // make sure a file actually exists
    modifier checkFile(bytes32 file_hash) {
        bytes memory file_check = bytes(fileHashDict[file_hash].file_name);
        require(file_check.length > 0);
        _;
    }

    // given a file hash, 
    function getFileInfo(bytes32 file_hash) internal view checkFile(file_hash) returns(file memory ) {
        return fileHashDict[file_hash];
    }
}