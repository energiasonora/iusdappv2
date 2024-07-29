// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeerPermitToken is ERC20, Ownable {
    mapping(address => uint256) public nonces;
    bytes32 public constant PEER_PERMIT_TYPEHASH = keccak256(
        "PeerPermit(address recipient,address valueCreator,uint256 value,uint256 nonce,uint256 deadline)"
    );

    bytes32 public DOMAIN_SEPARATOR;

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        uint256 chainId;
        assembly {
            chainId := chainid()
        }
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                keccak256(
                    "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
                ),
                keccak256(bytes(name)),
                keccak256(bytes("1")),
                chainId,
                address(this)
            )
        );
    }

    function peerPermit(
        address recipient,
        address valueCreator,
        uint256 value,
        uint256 deadline,
        uint8 vRecipient,
        bytes32 rRecipient,
        bytes32 sRecipient,
        uint8 vValueCreator,
        bytes32 rValueCreator,
        bytes32 sValueCreator
    ) external {
        require(block.timestamp <= deadline, "PeerPermit: expired deadline");

        bytes32 structHash = keccak256(
            abi.encode(
                PEER_PERMIT_TYPEHASH,
                recipient,
                valueCreator,
                value,
                nonces[recipient]++,
                deadline
            )
        );
        bytes32 hash = keccak256(
            abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR, structHash)
        );

        address signerRecipient = ecrecover(hash, vRecipient, rRecipient, sRecipient);
        require(signerRecipient != address(0) && signerRecipient == recipient, "PeerPermit: invalid recipient signature");

        address signerValueCreator = ecrecover(hash, vValueCreator, rValueCreator, sValueCreator);
        require(signerValueCreator != address(0) && signerValueCreator == valueCreator, "PeerPermit: invalid value creator signature");

        _mint(recipient, value);
    }
}
