const File = artifacts.require("File");

contract('File', (accounts) => {
//   // Test File.sol contract
  it('file should be initialized to a blood test', async () => {
    // Wait for the contract to be deployed
    const fileInstance = await File.deployed();
    // Call testFile function
    const file = await fileInstance.testFile();
    // Check the value is initialized.
    assert.equal(file.file_name, "blood test 1", "File incorrectly initialized.");
  });
});
