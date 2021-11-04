/*

  Author: Jack Antico, 11/4/2021
  Description: Super simple smart contract which allows you to store the name of
  your crush and view it.

*/

pragma solidity 0.5.1;

contract CrushKeeper {
    
    struct crushDetails {
        string nameOfCrush;
        string password;
    }
    
    uint256 numberOfCrushes;
    mapping(uint256 => crushDetails) crushs;
    
    // Contructor only runs once when contract is succesfully deployed
    constructor() public {
        numberOfCrushes = 0;
    }
    
    function createCrushEntry(string memory name, string memory password) public returns (string memory result) {
        crushDetails memory crush;
        crush.nameOfCrush = name;
        crush.password = password;
        crushs[numberOfCrushes] = crush;
        numberOfCrushes += 1;
        return append("Crush created! Write this next part down, it's your crush number: ", uint2str(numberOfCrushes - 1));
    }
    
    function seeCrush(uint256 crushNumber, string memory password) public returns (string memory result) {
        if (keccak256(bytes(crushs[crushNumber].password)) == keccak256(bytes(password))) {
            return crushs[crushNumber].nameOfCrush;
        } else {
            return "Incorrect password, no crush for you!";
        }
    }
    
    function seeNumberOfCrushes() public returns (string memory result) {
        return append("Number of crushes: ", uint2str(numberOfCrushes));
    }
    
    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
    
    function append(string memory a, string memory b) internal pure returns (string memory result) {
        return string(abi.encodePacked(a, b));
    }
    
    
}