// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// deployed to arbitrum sepolia 0x7a1031da7654E02bF3F287B52f534FC33e9a26CA

contract ETHWithMessage {
    event SentWithMessage(address indexed from, address indexed to, uint256 amount, string message);

    function sendWithMessage(address to, string memory message) external payable {
        require(msg.value > 0, "Must send ETH");
        require(to != address(0), "Invalid recipient");

        // Transfer ETH to the recipient
        payable(to).transfer(msg.value);

        // Emit an event with the message
        emit SentWithMessage(msg.sender, to, msg.value, message);
    }
}
