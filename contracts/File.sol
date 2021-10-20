pragma solidity >=0.4.25 <0.7.0;

// File contract
contract File {
    mapping (bytes32 => filesInfo) internal hashToFile;
    
    struct file {
        string file_name;
        string record_type;
        address uploader;
    }
}