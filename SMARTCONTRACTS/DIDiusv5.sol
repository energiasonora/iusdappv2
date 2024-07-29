// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// HOW IT WORKS
// 1. upser calls registredDID with the cid of the ipfs document as argument
// 2. only user can update his own did
// 3. public can see and recall DID

contract DIDRegistryV5 {
    mapping(address => string) public cids;
    mapping(bytes32 => string) public didDocuments;

    event DIDRegistered(bytes32 indexed didHash, string cid);
    event DIDUpdated(bytes32 indexed didHash, string cid);

    function registerDID(string memory _cid) public {
        address ethAddress = msg.sender;
        
        // Construct DID string
        string memory did = string(abi.encodePacked("did:ius:", toHex(ethAddress)));

        // Calculate DID hash
        bytes32 didHash = keccak256(bytes(did));

        // Ensure DID is not already registered
        require(bytes(didDocuments[didHash]).length == 0, "DID already exists");

        // Store CID for the caller's DID
        cids[ethAddress] = _cid;

        // Store DID document
        didDocuments[didHash] = _cid;

        emit DIDRegistered(didHash, _cid);
    }

    // Retrieve CID associated with a DID
    function getCID(string memory _did) public view returns (string memory) {
        bytes32 didHash = keccak256(bytes(_did));
        return didDocuments[didHash];
    }

    // Update CID associated with a DID
    function updateDID(string memory _newCid) public {
        address ethAddress = msg.sender;
        
        // Construct DID string
        string memory did = string(abi.encodePacked("did:ius:", toHex(ethAddress)));

        // Calculate DID hash
        bytes32 didHash = keccak256(bytes(did));

        // Ensure DID exists
        require(bytes(didDocuments[didHash]).length != 0, "DID does not exist");

        // Update CID for the caller's DID
        cids[ethAddress] = _newCid;

        // Update DID document
        didDocuments[didHash] = _newCid;

        emit DIDUpdated(didHash, _newCid);
    }

    // Function to convert address to hex string
    function toHex(address _addr) internal pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(_addr)));
        bytes memory alphabet = "0123456789aAbBcCdDeEfF";
        bytes memory str = new bytes(42);
        str[0] = '0';
        str[1] = 'x';
        for (uint i = 0; i < 20; i++) {
            str[2 + i * 2] = alphabet[uint(uint8(value[i + 12] >> 4))];
            str[3 + i * 2] = alphabet[uint(uint8(value[i + 12] & 0x0f))];
        }
        return string(str);
    }

 
 
   function validateDIDFormat(string memory _did) internal pure returns (bool) {
        bytes memory didBytes = bytes(_did);
        bytes memory prefix = bytes("did:ius:");

        // Check for exact prefix "did:ius:"
        if (didBytes.length != prefix.length + 42) {
            return false;
        }

        for (uint i = 0; i < prefix.length; i++) {
            if (didBytes[i] != prefix[i]) {
                return false;
            }
        }

        return true;
    }
     
 
}
