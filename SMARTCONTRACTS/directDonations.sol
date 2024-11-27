// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// deployed to arbitrum sepolia 

contract DirectDonationWithMessage {
    // Event for logging donations
    event DonationReceived(address indexed donor, address indexed recipient, uint256 amount, string message);

    // Address of the donation recipient
    address public recipient;

    constructor(address _recipient) {
        require(_recipient != address(0), "Recipient address cannot be zero");
        recipient = _recipient;
    }

    // Donate function sends ETH directly to the recipient
    function donate(string memory message) external payable {
        require(msg.value > 0, "Donation must be greater than 0");

        // Transfer the donation amount directly to the recipient
        (bool success, ) = recipient.call{value: msg.value}("");
        require(success, "Failed to send donation");

        // Emit the donation event
        emit DonationReceived(msg.sender, recipient, msg.value, message);
    }
}
