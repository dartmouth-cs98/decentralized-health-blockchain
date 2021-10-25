const File = artifacts.require("File");

contract('File', (accounts) => {
  // Test File.sol contract
  it('uses testFile method to check deployment of File.sol', async () => {
    // Wait for the contract to be deployed
    const fileInstance = await File.deployed();
    // Call testFile function
    const tfile = await fileInstance.testFile();
    // 
    console.log("======================");
    console.log(tfile);
    assert.equal(tfile[0], 'blood test 1');
  });
});