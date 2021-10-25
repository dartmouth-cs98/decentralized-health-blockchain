const HelloWorld = artifacts.require("HelloWorld");

contract('HelloWorld', (accounts) => {
  // Test HelloWorld.sol contract
  it('greeting variable should be initialized to "Hello World!"', async () => {
    // Wait for the contract to be deployed
    const helloWorldInstance = await HelloWorld.deployed();
    // Call getGreeting function
    const greeting = await helloWorldInstance.getGreeting();
    // Check the value is initialized.
    assert.equal(greeting, "Hello World!", "String incorrectly initialized.");
  });
});
