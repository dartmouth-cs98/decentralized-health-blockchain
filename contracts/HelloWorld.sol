// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.7.0;

// We are trying our hand at sending a contract with the message "Hello World"

contract HelloWorld {
	string public greeting = "Hello World!";

	function getGreeting() public view returns(string memory){
		return greeting;
	}
}
