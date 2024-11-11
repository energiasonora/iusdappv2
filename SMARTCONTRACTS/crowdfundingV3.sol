// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;
// WHAT IT DOES
// this sm allows to collect funds and let the admin widthraw partial amounts as needed.

// zkEVM polygon 0x4bF546fC1A24F24c1F88e315B0ED96BF853C3D1a
// MATIC 0x691E71Ff60cF56d4f6417b203b25A683afE9a9B6
// MUMBAI 0xa438027C37604a42fa7821EA642BFd5b2FcA9E21
//  FIX v3, problem: cannot re-withdraw if raisedAmount doesnt match contract's balance
// MATIC 4000000000000000000000 3000 euro aprox
// https://polygonscan.com/address/0x691e71ff60cf56d4f6417b203b25a683afe9a9b6
contract Crowdfundingv3 {

    address public owner;
    uint public goal;
    uint public deadline;
    uint public raisedAmount = 0;
    mapping(address => uint) public contributions;
    mapping(address => string) public pseudonyms;
    address[] public contributors; // Array to store contributor addresses

    event ContributionMade(address indexed contributor, uint amount);
    event FundsWithdrawn(address indexed recipient, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the recipient can call this function");
        _;
    }

    constructor(uint _goal, uint _durationInDays) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + (_durationInDays * 1 days);
    }

 
  receive() external payable {
       if (contributions[msg.sender] == 0) {//This array keeps track of all unique contributors to the campaign.
            contributors.push(msg.sender);
        }
        raisedAmount += msg.value;
        contributions[msg.sender] += msg.value;

        // Set or update the pseudonym
        pseudonyms[msg.sender] = "contributor";

        // Emit the ContributionMade event
        emit ContributionMade(msg.sender, msg.value);
  }

    function contribute(string memory _pseudonym) public payable {
        require(block.timestamp < deadline, "Crowdfunding period has ended");
         if (contributions[msg.sender] == 0) {//This array keeps track of all unique contributors to the campaign.
            contributors.push(msg.sender);
        }
        raisedAmount += msg.value;
        contributions[msg.sender] += msg.value;

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


    function getContributorPseudonym(address contributor) public view returns (string memory) {
        return pseudonyms[contributor];
    }
    function withdrawFunds(uint _amount) public onlyOwner {
        require(_amount <= address(this).balance, "Insufficient contract balance");

        payable(msg.sender).transfer(_amount);
        
        // Emit the FundsWithdrawn event
        emit FundsWithdrawn(msg.sender, _amount);
    }

    function withdrawAllFunds() public onlyOwner {
        require(address(this).balance > 0, "No funds available to withdraw");

        uint amountToWithdraw = address(this).balance;
        payable(msg.sender).transfer(amountToWithdraw);
        
        // Emit the FundsWithdrawn event
        emit FundsWithdrawn(msg.sender, amountToWithdraw);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function hasGoalReached() public view returns (bool) {
        return address(this).balance >= goal;
    }

    function timeLeft() public view returns (uint) {
        require(block.timestamp < deadline, "Crowdfunding period has ended");
        return deadline - block.timestamp;
    }
}
