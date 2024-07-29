// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.5.0/access/AccessControl.sol";
import "@openzeppelin/contracts@4.5.0/utils/Counters.sol";

// WHAT IT DOES
// This contract allows users to mint an ERC721 NFT with crowdfunding campaign details (_goal and _duration).
// The contract manages contributions to each campaign and allows the campaign owner to withdraw funds.

contract CrowdfundingNFT is ERC721 , AccessControl {

// COUNTERS
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdTracker;

 
// ---------------------------------------
// ROLES
    bytes32 public constant DAO_ROLE = keccak256("DAO_ROLE");




    struct Campaign {
        uint goal;
        uint deadline;
        uint raisedAmount;
        address owner;
        mapping(address => uint) contributions;
        mapping(address => string) pseudonyms;
        address[] contributors;
    }



    mapping(uint => Campaign) public campaigns;

    event ContributionMade(uint indexed tokenId, address indexed contributor, uint amount);
    event FundsWithdrawn(uint indexed tokenId, address indexed recipient, uint amount);
    event CampaignCreated(uint indexed tokenId, address indexed owner, uint goal, uint deadline);

    // constructor() ERC721("CrowdfundingNFT", "CFNFT")   {}

 
    // ---------------------------------------
    // CONSTRUCTOR
    // constructor(uint256 _mintLimit) ERC721("ALBUMLOG", "ALOG") {
    constructor() ERC721("CrowdfundingNFT", "CFNFT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);// during testing phase, this role is renounceable after that phase
        _grantRole(DAO_ROLE, msg.sender);
        // _grantRole(SUBSCRIBER_ROLE, msg.sender);
    }
    function mintCampaign(uint _goal, uint _durationInDays) public {
       
        _tokenIdTracker.increment();//start with 1
        uint tokenId = _tokenIdTracker.current();
        _mint(msg.sender, tokenId);

        Campaign storage newCampaign = campaigns[tokenId];
        newCampaign.goal = _goal;
        newCampaign.deadline = block.timestamp + (_durationInDays * 1 days);
        newCampaign.owner = msg.sender;

        _tokenIdTracker.increment();

        emit CampaignCreated(tokenId, msg.sender, _goal, newCampaign.deadline);
    }

    function contribute(uint tokenId, string memory _pseudonym) public payable {
        Campaign storage campaign = campaigns[tokenId];

        require(block.timestamp < campaign.deadline, "Crowdfunding period has ended");
        if (campaign.contributions[msg.sender] == 0) {
            campaign.contributors.push(msg.sender);
        }
        campaign.raisedAmount += msg.value;
        campaign.contributions[msg.sender] += msg.value;
        campaign.pseudonyms[msg.sender] = _pseudonym;

        emit ContributionMade(tokenId, msg.sender, msg.value);
    }

    function getContributorsCount(uint tokenId) public view returns (uint256) {
        return campaigns[tokenId].contributors.length;
    }

    function getContributorByIndex(uint tokenId, uint index) public view returns (address) {
        require(index < campaigns[tokenId].contributors.length, "Index out of bounds");
        return campaigns[tokenId].contributors[index];
    }

    function getContributorPseudonym(uint tokenId, address contributor) public view returns (string memory) {
        return campaigns[tokenId].pseudonyms[contributor];
    }

    function withdrawFunds(uint tokenId, uint _amount) public {
        Campaign storage campaign = campaigns[tokenId];
        require(msg.sender == campaign.owner, "Only the campaign owner can call this function");
        require(_amount <= address(this).balance, "Insufficient contract balance");

        payable(msg.sender).transfer(_amount);
        emit FundsWithdrawn(tokenId, msg.sender, _amount);
    }

    function withdrawAllFunds(uint tokenId) public {
        Campaign storage campaign = campaigns[tokenId];
        require(msg.sender == campaign.owner, "Only the campaign owner can call this function");
        require(address(this).balance > 0, "No funds available to withdraw");

        uint amountToWithdraw = address(this).balance;
        payable(msg.sender).transfer(amountToWithdraw);
        emit FundsWithdrawn(tokenId, msg.sender, amountToWithdraw);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function hasGoalReached(uint tokenId) public view returns (bool) {
        return campaigns[tokenId].raisedAmount >= campaigns[tokenId].goal;
    }

    function timeLeft(uint tokenId) public view returns (uint) {
        require(block.timestamp < campaigns[tokenId].deadline, "Crowdfunding period has ended");
        return campaigns[tokenId].deadline - block.timestamp;
    }
      function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
