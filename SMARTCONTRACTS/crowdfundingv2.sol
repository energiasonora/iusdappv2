// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

// goal 200eu 20000000000
// goal 5 eth 5000000000000000000
// goal 0.5 eth 500000000000000000
// SEPOLIA 0x3A7a5B766D4277d163a3A8Ce2322930Bb8D03C2B

contract Crowdfunding {
    address public owner;
    uint public goal;
    uint public deadline;
    uint public raisedAmount = 0;

    address[] public contributors; // Array to store contributor addresses
    mapping(address => uint) public contributions;
    mapping(address => string) public pseudonyms;

    event ContributionMade(address indexed contributor, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(uint _goal, uint _durationInDays) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + (_durationInDays * 1 days);
    }

    function contribute(string memory _pseudonym) public payable {
        require(block.timestamp < deadline, "Crowdfunding period has ended");

        if (contributions[msg.sender] == 0) {
            contributors.push(msg.sender);
        }

        contributions[msg.sender] += msg.value;
        raisedAmount += msg.value;

        // Set or update the pseudonym
        pseudonyms[msg.sender] = _pseudonym;

        // Emit the ContributionMade event
        emit ContributionMade(msg.sender, msg.value);
    }

    function getContributorsCount() public view returns (uint256) {
        return contributors.length;
    }

    function getContributorByIndex(uint index) public view returns (address) {
        require(index < contributors.length, "Index out of bounds");
        return contributors[index];
    }

    function getContributorPseudonym(
        address contributor
    ) public view returns (string memory) {
        return pseudonyms[contributor];
    }

    function withdrawFunds() public onlyOwner {
        require(raisedAmount >= 0, "No funds to withdraw");

        payable(owner).transfer(raisedAmount);
        // raisedAmount = 0; // Reset the raisedAmount after withdrawal
    }

    function hasGoalReached() public view returns (bool) {
        return raisedAmount >= goal;
    }

    function timeLeft() public view returns (uint) {
        require(block.timestamp < deadline, "Crowdfunding period has ended");
        return deadline - block.timestamp;
    }
}
