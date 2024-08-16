// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// _did:
// "did:meter:0x1234567890123456789012345678901234567890"
// _publicKey:
// "0x04a17b10b194d17e1c2b918e08d8bc2d90b7eabbc06a741b5a407c81f11bf7a45c8af1febbf4a165356c06f5d51e5b1c4d78388a10e05666f3f3054e48ecff637"
 pragma solidity ^0.8.0;

contract DIDRegistryV2 {
    mapping(bytes32 => mapping(string => string)) public didDocuments;
    mapping(address => string) public publicKeys;

    event DIDRegistered(bytes32 indexed did, string publicKey);
    event DIDUpdated(bytes32 indexed did, string publicKey);

    function registerDID(bytes32 _did, string memory _publicKey) public {
        require(bytes(didDocuments[_did]["publicKey"]).length == 0, "DID already exists");
        require(validateDIDFormat(_did), "Invalid DID format");
        didDocuments[_did]["publicKey"] = _publicKey;
        publicKeys[msg.sender] = _publicKey;
        emit DIDRegistered(_did, _publicKey);
    }

    function updateDID(bytes32 _did, string memory _publicKey) public {
        require(bytes(didDocuments[_did]["publicKey"]).length != 0, "DID does not exist");
        didDocuments[_did]["publicKey"] = _publicKey;
        publicKeys[msg.sender] = _publicKey;
        emit DIDUpdated(_did, _publicKey);
    }

    function getPublicKey(bytes32 _did) public view returns (string memory) {
        return didDocuments[_did]["publicKey"];
    }

    function validateDIDFormat(bytes32 _did) internal pure returns (bool) {
        string memory didString = bytes32ToString(_did);
        bytes memory didBytes = bytes(didString);

        // Check for prefix "did:meter:"
        bytes memory prefix = bytes("did:meter:");
        if (didBytes.length < prefix.length) {
            return false;
        }

        for (uint i = 0; i < prefix.length; i++) {
            if (didBytes[i] != prefix[i]) {
                return false;
            }
        }

        // Check for the existence of the user address part
        if (didBytes.length <= prefix.length) {
            return false;
        }

        return true;
    }

    function bytes32ToString(bytes32 _bytes32) internal pure returns (string memory) {
        bytes memory bytesArray = new bytes(32);
        for (uint256 i; i < 32; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }
}

