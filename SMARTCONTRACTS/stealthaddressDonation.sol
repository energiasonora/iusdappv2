// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

// Approach:  We use a Public Key Stored in the Smart Contract
// simplest solution is for the smart contract to store a public key that donors can retrieve. 
// The key can belong to the contract owner or represent a "donation account."

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract DonationContract {



    address public owner;
    bytes public contractPublicKey;

// Events for logging
    event DonationReceived(address indexed donor, uint256 amount);
    event DonationWithdrawn(address indexed recipient, uint256 amount);
    event TokenWithdrawn(address indexed recipient, uint256 amount, address token);

// MAPPINGS
   mapping(address => uint256) public donations;

// A
    constructor() {
        // Set the owner to the contract deployer
        owner = msg.sender;

        // Derive the public key from the owner's address
        // NOTE: You need the actual public key for cryptographic operations.
        // Ethereum does not natively expose the public key of the owner directly on-chain.
        // The public key must be shared or derived during signing off-chain.
    }


// B- Full Deployment with Auto-PublicKey Setup
    // constructor(bytes memory _contractPublicKey) {
    //     owner = msg.sender; // Contract deployer becomes the owner
    //     contractPublicKey = _contractPublicKey; // Set the public key during deployment
    // }


 
    // event DonationReceived(address indexed stealthAddress, uint256 amount);

    function donate(address stealthAddress) external payable {
        require(msg.value > 0, "Donation must be greater than 0");

        // Record the donation
        donations[stealthAddress] += msg.value;

        emit DonationReceived(stealthAddress, msg.value);
    }
    
    
    // Receive Ether donations
    receive() external payable {
        emit DonationReceived(msg.sender, msg.value);
    }

    // Get contract's Ether balance
    function getEtherBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // Get ERC-20 token balance
    function getTokenBalance(address token) external view returns (uint256) {
        return IERC20(token).balanceOf(address(this));
    }

    // Withdraw Ether donations (only owner can withdraw)
    function withdrawEther() external {
        require(msg.sender == owner, "Only owner can withdraw");
        uint256 balance = address(this).balance;
        require(balance > 0, "No Ether to withdraw");

        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Ether transfer failed");

        emit DonationWithdrawn(owner, balance);
    }

    // Withdraw ERC-20 token donations (only owner can withdraw)
    function withdrawTokens(address token) external {
        require(msg.sender == owner, "Only owner can withdraw");
        uint256 balance = IERC20(token).balanceOf(address(this));
        require(balance > 0, "No tokens to withdraw");

        require(IERC20(token).transfer(owner, balance), "Token transfer failed");

        emit TokenWithdrawn(owner, balance, token);
    }


    // Fallback to manually set the public key if required
    function setContractPublicKey(bytes memory _contractPublicKey) external {
        require(msg.sender == owner, "Only owner can set the public key");
        contractPublicKey = _contractPublicKey;
    }

    function getContractPublicKey() external view returns (bytes memory) {
        return contractPublicKey;
    }

}
