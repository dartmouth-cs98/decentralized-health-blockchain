# decentralized-health-blockchain

## Primary Authors: Gabe Kotsonis, Kevin Cai

### Current progress:
We have initialized truffle, and have gotten tangible feedback from Ganache that the default metacoin contract went through. Following this, we wrote a HelloWorld.sol script that returns the string "Hello World!" when the method getGreeting() is called. To test this, we wrote a test script in metacoin.js, which, after checking that MetaCoin.sol was deployed properly, waits for the HelloWorld smart contract to be deployed, and then awaits the greeting and checks that it is actually "Hello World!". Our test case passed, so our HelloWorld has proper functionality.