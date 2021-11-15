# decentralized-health-blockchain

## Primary Authors: Gabe Kotsonis, Kevin Cai
### Code inspired by: https://github.com/dadheech-vartika/Medical-Chain


## Data Structure:
- Doctor class: stores doctor name, clinic they work for, their wallet address, and list of patient wallet addresses.
- Patient class: stores name, age, wallet address, file hashes, and list of doctor wallet addresses
- File class: stores a dictionary that maps file hashes to file info objects. File info objects contain file name, record type, the file contents (as a string), and the name of the doctor who uploaded the document.
- Service smart contract: inherits functionality from doctor, patient, and file classes. Used for all the wiring between them (getting patient info on the doctor side, adding new files, etc.). All functionality is achieved through the service contract, beginning with signing up patients and doctors, and granting either access to files.

### Current progress:
- We have verified proper deployment and functionality of our service smart contract and the data structures within it. So far, our included methods tackle just primary features (signing up, accessing records, granting doctors access, viewing records, etc.). Each of these meethods is handled within our main service smart contract, which we have deployed to the Ethereum Ropsten test network and utilized to test our contract methods with our frontend locally (event handlers trigger the deployment of service smart contract methods to the Ropsten test network). For more information about how contract methods are triggered and handlded on the frontend, see the decentralized-health-frontend README.md.
- Methods we have implemented so far:
    1. getDoctorInfo()
    2. signupDoctor()
    3. getFileHash()
    4. getFileInfo()
    5. getPatientInfo()
    6. signupPatient()
    7. addFile()
    8. grantDoctorAccess()
    9. getPatientInfoForDoctor()
    10. getDoctorInfoForPatient()
    11. A number of internal modifiers to verify that wallet addresses given as method parameters are valid, and that doctors have been granted access to the files of patients they want to upload files for.

## Testing
- We began with testing the methods associated with our three primary data structures (doctor, patient, and file). These methods include signing up a doctor or patient, getting info about a person, retrieving file hashes, etc. From there, we put together our data structures into the service contract, and worked on testing to ensure that the methods interacted with our structures properly (e.g. making sure that when granting access to a doctor, that doctor's info can now be retrieved from a patient's doctor list, etc.). We have ensured that all our methods required for the MVP work as intended, which one can check using the following procedure:

    1. Make sure truffle is installed.
    2. Download ganache and press "quickstart" upon opening up the app.
    3. Run `truffle compile` from the terminal command line in this directory.
    4. Run `truffle migrate` to deploy and migrate the service smart contract.
    5. Run `truffle test` to call our javascript test files in the test directory. These files run tests that check basic wiring of our contract methods, while also passively ensuring that our basic structure methods work properly (i.e. you are not be able to grant a doctor access to your files without first signing up yourself and the doctor).