# decentralized-health-blockchain

## Primary Authors: Gabe Kotsonis, Kevin Cai
### Code inspired by: https://github.com/dadheech-vartika/Medical-Chain


## Data Structure:
- Doctor class: stores doctor name, id, and list of patient wallet addresses.
- Patient class: stores name, age, id, file hashes, and list of doctor wallet addresses
- File class: stores a dictionary that maps file hashes to file info objects. File info objects contain file name, record type, and the name of the doctor who uploaded the document.
- Service smart contract: inherits functionality from doctor, patient, and file classes. Used for all the wiring between them (getting patient info on the doctor side, adding new files, etc.)

## Testing
- 

### Current progress:
We have initialized truffle, and have gotten tangible feedback from Ganache that the default metacoin contract went through. Following this, we wrote a HelloWorld.sol script that returns the string "Hello World!" when the method getGreeting() is called. To test this, we wrote a test script in metacoin.js, which, after checking that MetaCoin.sol was deployed properly, waits for the HelloWorld smart contract to be deployed, and then awaits the greeting and checks that it is actually "Hello World!". Our test case passed, so our HelloWorld has proper functionality.

After this, we wrote preliminary contracts for our patient, doctor, file, and service classes that provide initial methods we foresee needing to use in the future. Each class/contract has getters and setters, and we are working on implementing the memory storage and wiring between them. After this, we wrote four separate testfiles for each of our contracts to ensure that they deployed properly and we can verify the address of the sender. Looking forward, we hope to test each of our methods in our four base class smart contracts, as well as fully flesh our our service contract to complete all the necessary wiring.