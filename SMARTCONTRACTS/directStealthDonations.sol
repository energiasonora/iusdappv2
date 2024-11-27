// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// deployed for :
// address 0x55Ca2D7146dA5a400F214007F01EDde12C660819
// pubkey 0x0339a514f2caaf9fef8e38be18ac73901a62dca3a53d5d7638032fe6fab40c5e4a
// in arbitrum sepolia at 0x97618a023B7748be9d6f7B4d8D8bFe04f6528D65

// Enhanced Smart Contract with Stealth Address Support

// allow donors to calculate a unique stealth address for the recipient and send donations to that address.
// 
// Store the recipient's public key: Instead of storing a fixed recipient address, the smart contract will store the recipient's public key. This public key is used by donors to derive unique stealth addresses.

// Emit the derived address: For traceability, emit the stealth address where donations are sent.

// Allow withdrawal by the recipient: Implement functionality to enable the recipient to withdraw funds from stealth addresses.


contract StealthDonation {
    // Event for logging donations
    event DonationReceived(address indexed stealthAddress, uint256 amount, string message);
    event FundsWithdrawn(address indexed recipient, uint256 amount);

    // Recipient's public key
    address public recipient;
    bytes public recipientPublicKey;

    // Map stealth addresses to balances
    mapping(address => uint256) public stealthBalances;

    constructor(address _recipient, bytes memory _recipientPublicKey) {
        require(_recipient != address(0), "Recipient address cannot be zero");
        require(_recipientPublicKey.length > 0, "Recipient public key cannot be empty");
        recipient = _recipient;
        recipientPublicKey = _recipientPublicKey;
    }

    // Function to receive donations
    function donate(address stealthAddress, string memory message) external payable {
        require(msg.value > 0, "Donation must be greater than 0");
        require(stealthAddress != address(0), "Stealth address cannot be zero");

        // Update stealth balance
        stealthBalances[stealthAddress] += msg.value;

        // Emit the donation event
        emit DonationReceived(stealthAddress, msg.value, message);
    }

    // Function for recipient to withdraw funds from a stealth address
    function withdrawFromStealth(address stealthAddress) external {
        require(msg.sender == recipient, "Only the recipient can withdraw");
        uint256 balance = stealthBalances[stealthAddress];
        require(balance > 0, "No funds available for withdrawal");

        // Reset the balance
        stealthBalances[stealthAddress] = 0;

        // Transfer the balance to the recipient
        (bool success, ) = recipient.call{value: balance}("");
        require(success, "Failed to transfer funds");

        // Emit the withdrawal event
        emit FundsWithdrawn(recipient, balance);
    }
}
