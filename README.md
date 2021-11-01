# decentralized-health-blockchain

## Primary Authors: Gabe Kotsonis, Kevin Cai
### Code inspired by: https://github.com/dadheech-vartika/Medical-Chain


## Data Structure:
- Doctor class: stores doctor name, clinic they work for, their wallet address, and list of patient wallet addresses.
- Patient class: stores name, age, wallet address, file hashes, and list of doctor wallet addresses
- File class: stores a dictionary that maps file hashes to file info objects. File info objects contain file name, record type, and the name of the doctor who uploaded the document.
- Service smart contract: inherits functionality from doctor, patient, and file classes. Used for all the wiring between them (getting patient info on the doctor side, adding new files, etc.)

## Testing
- Added simple testing for Patient.sol contract - calling the signupPatient method to create a new patient instance, checking that the instance of the class exists and the correct address is calling the smart contract.
- Added simple testing for Doctor.sol contract - calling the signupDoctor method to create a new patient instance, checking that the instance of the class exists and the correct address is calling the smart contract.
- Added simple testing for Test.sol contract. We have written a method to test the deployment of the smart contract and verifying that the function returns parameters as expected.
- Added simple testing for the Service.sol contract - we wrote a testService  method which tests the deployment of the smart contract and makes sure the contract sender's address is the same as the current user's.

### Current progress:
We have initialized truffle, and have gotten tangible feedback from Ganache that the default metacoin contract went through. Following this, we wrote a HelloWorld.sol script that returns the string "Hello World!" when the method getGreeting() is called. To test this, we wrote a test script in metacoin.js, which, after checking that MetaCoin.sol was deployed properly, waits for the HelloWorld smart contract to be deployed, and then awaits the greeting and checks that it is actually "Hello World!". Our test case passed, so our HelloWorld has proper functionality.

After this, we wrote preliminary contracts for our patient, doctor, file, and service classes that provide initial methods we foresee needing to use in the future. Each class/contract has getters and setters, and since then, we have worked on implementing the memory storage and wiring between them. After this, we wrote four separate testfiles for each of our contracts to ensure that they deployed properly and we can verify the address of the sender, as well as check that data passed in as parameters to the contracts gets stored properly. 

In Sprint 2, we expanded upon our testing for each of the smart contracts, and wrote new methods in the Service smart contract that allow greater data flow and interaction between the different base class smart contracts. These methods compile properly, and appear to work on a surface level, so in the next sprint, we hope to write more detailed test scripts for these new methods, as well as work on adding the final few methods we need for the MVP of our product.