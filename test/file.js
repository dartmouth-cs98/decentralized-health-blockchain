const File = artifacts.require("File");

contract('File', (accounts) => {
  // Test File.sol contract
  it('creates a new doctor by calling the testFile method', async () => {
    // Wait for the contract to be deployed
    const fileInstance = await File.deployed();
    // Call testFile function
    const tfile = await fileInstance.testFile();
    // 
    console.log("======================");
    console.log(typeof(accounts[0]));
    assert.equal(tfile.receipt.from.toUpperCase(), accounts[0].toUpperCase());
  });
});