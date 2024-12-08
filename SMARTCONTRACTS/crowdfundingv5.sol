// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

// deployed arb sepolia 0xE59fd4a07514E7C485545F5acC99299111fd22c6

// HOW TO IMPLEMENT IT
// ideally, the recipient should sign something so we can get his pubkey

// WHAT IT DOES
// this sm allows to collect funds and let the admin widthraw partial amounts as needed.
// arbsepolia:

// v5: with stealth address support
// Enhanced Smart Contract with Stealth Address Support
// allow donors to calculate a unique stealth address for the recipient and send donations to that address.
// Store the recipient's public key: Instead of storing a fixed recipient address, the smart contract will store the recipient's public key. This public key is used by donors to derive unique stealth addresses.
// Emit the derived address: For traceability, emit the stealth address where donations are sent.
// Allow withdrawal by the recipient: Implement functionality to enable the recipient to withdraw funds from stealth addresses.


// deploy
// (0.33 eth in wei 330000000000000000)

// recipient : 0x2491207eA01b4EFd267690F11aA17BE6c2d70072
// pubKey: 0x0497eab0841786aeae14135af5e26750626e46e2e15a412b6a319dd2ce7f323c805d67fcfb0f8ea1f27959e486e11e49926fbf4b1c2b9252daa20283e200e3b1b3
// _GOAL: 330000000000000000
// _DURATIONINDAYS: 33

contract Crowdfundingv5 {

    bytes public recipientPublicKey;// Recipient's public key: the public address of the recipient of the donation
    address public recipient;
    address public owner;
    uint public goal;
    uint public deadline;
    uint public raisedAmount = 0;
    mapping(address => uint256) public stealthBalances;// Map stealth addresses to balances
    mapping(address => uint) public contributions;
    mapping(address => string) public pseudonyms;
    address[] public contributors; // Array to store contributor addresses

    // event DonationReceived(address indexed stealthAddress, uint256 amount, string message);//mix
    event ContributionMade(address indexed contributor, uint amount);
    event FundsWithdrawn(address indexed recipient, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the recipient can call this function");
        _;
    }

  constructor(address _recipient, bytes memory _recipientPublicKey,uint _goal, uint _durationInDays) {
        require(_recipient != address(0), "Recipient address cannot be zero");
        require(_recipientPublicKey.length == 33 || _recipientPublicKey.length == 65, "Invalid public key format");

        recipient = _recipient;
        recipientPublicKey = _recipientPublicKey;
    
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

    function contributestealth(address stealthAddress, string memory _pseudonym) external payable {
        require(block.timestamp < deadline, "Crowdfunding period has ended");
                if (contributions[msg.sender] == 0) {//This array keeps track of all unique contributors to the campaign.
                    contributors.push(msg.sender);
                }
                 // Update stealth balance
        stealthBalances[stealthAddress] += msg.value;

                raisedAmount += msg.value;
                contributions[msg.sender] += msg.value;

                // Set or update the pseudonym
                pseudonyms[msg.sender] = _pseudonym;

                // Emit the ContributionMade event
                emit ContributionMade(msg.sender, msg.value);
    }

    // Function to receive donations //mix
    // function donate(address stealthAddress, string memory message) external payable {
    //     require(msg.value > 0, "Donation must be greater than 0");
    //     require(stealthAddress != address(0), "Stealth address cannot be zero");

    // // Transfer the donation amount directly to the recipient
    //     (bool success, ) = recipient.call{value: msg.value}("");
    //     require(success, "Failed to send donation");

    //     // Update stealth balance
    //     stealthBalances[stealthAddress] += msg.value;

    //     // Emit the donation event
    //     emit DonationReceived(stealthAddress, msg.value, message);
    // }


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
