# decentralized-health-blockchain

## Primary Authors: Gabe Kotsonis, Kevin Cai
### Code inspired by: https://github.com/dadheech-vartika/Medical-Chain

## Data Structure:
- Doctor class: stores doctor name, id, and list of patient wallet addresses.
- Patient class: stores name, age, id, file hashes, and list of doctor wallet addresses
- File class: stores a dictionary that maps file hashes to file info objects. File info objects contain file name, record type, and the name of the doctor who uploaded the document.