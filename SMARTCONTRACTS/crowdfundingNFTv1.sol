// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// deployed arb sepolia: 0x23f15345392Fd2caCCaC1CE2361eA28669E8326C

// Key Changes and Additions
// ERC-721 Integration :
// The contract inherits from OpenZeppelin's ERC721 and Ownable contracts.
// Each crowdfunding campaign is represented by a unique NFT, identified by its tokenId.
// Campaign Struct :
// A Campaign struct stores all the details of a crowdfunding campaign, including the recipient, goal, deadline, contributions, and more.
// NFT Minting :
// When a user creates a campaign, an NFT is minted (_safeMint) and assigned to the creator. The tokenId serves as the unique identifier for the campaign.
// Access Control :
// Only the owner of the NFT (campaign creator) can withdraw funds from the campaign.
// Events :
// New events (CampaignCreated, ContributionMade, FundsWithdrawn) are emitted to track campaign creation, contributions, and fund withdrawals.
// Helper Functions :
// Functions like getContributorsCount, getContributorByIndex, and getContributorPseudonym allow querying campaign details.

// Deployment and Usage
// Deploy the Contract :
// Deploy the CrowdfundingNFT contract on your desired network (e.g., Arbitrum Sepolia).
// Create a Campaign :
// Call the createCampaign function, passing in the recipient address, public key, goal, and duration. This will mint an NFT representing the campaign.
// Contribute to a Campaign :
// Users can contribute to a campaign by calling the contribute function and specifying the tokenId of the campaign.
// Withdraw Funds :
// The owner of the NFT (campaign creator) can withdraw funds using the withdrawFunds or withdrawAllFunds functions.

// deploy EXAMPLE
// (0.33 eth in wei 330000000000000000)

// recipient : 0x2491207eA01b4EFd267690F11aA17BE6c2d70072
// pubKey: 0x0497eab0841786aeae14135af5e26750626e46e2e15a412b6a319dd2ce7f323c805d67fcfb0f8ea1f27959e486e11e49926fbf4b1c2b9252daa20283e200e3b1b3
// _GOAL: 330000000000000000
// _DURATIONINDAYS: 33

// renewCampaign Function :
// This function allows the owner of the NFT (campaign creator) to renew a campaign after it has ended.
// The owner can specify a new duration (in days) and optionally update the goal.
// The campaign's deadline is extended, and the goal is updated if a new goal is provided.
// Validation :
// The function ensures that only the NFT owner can renew the campaign.
// It also checks that the campaign has already ended (block.timestamp >= campaign.deadline) before allowing renewal.
// Event :
// A new event CampaignRenewed is emitted to log the renewal of a campaign, including the new goal and deadline.
// How to Use the Renewal Feature
// Check Campaign Status :
// Before renewing, ensure the campaign has ended by checking the timeLeft function or comparing the current timestamp with the campaign's deadline.
// Renew the Campaign :
// Call the renewCampaign function, passing in the tokenId of the campaign, the new duration (in days), and optionally a new goal.
// Contribute Again :
// After renewal, users can continue contributing to the campaign until the new deadline.



contract CrowdfundingNFT is ERC721, Ownable {
    // Struct to represent a crowdfunding campaign
    struct Campaign {
        address recipient;
        bytes recipientPublicKey;
        uint goal;
        uint deadline;
        uint raisedAmount;
        mapping(address => uint256) contributions;
        mapping(address => string) pseudonyms;
        address[] contributors;
    }

    // Mapping from token ID to campaign details
    mapping(uint256 => Campaign) public campaigns;

    // Token ID counter
    uint256 public nextTokenId;

    // Events
    event CampaignCreated(uint256 indexed tokenId, address indexed creator, address indexed recipient, uint goal, uint deadline);
    event ContributionMade(uint256 indexed tokenId, address indexed contributor, uint amount);
    event FundsWithdrawn(uint256 indexed tokenId, address indexed recipient, uint amount);
    event CampaignRenewed(uint256 indexed tokenId, uint newGoal, uint newDeadline);

    /**
     * @dev Constructor initializes the ERC721 and Ownable contracts.
     */
    constructor() ERC721("CrowdfundingNFT", "CFNFT") Ownable(msg.sender) {}

    /**
     * @dev Creates a new crowdfunding campaign and mints an NFT for it.
     */
    function createCampaign(
        address _recipient,
        bytes memory _recipientPublicKey,
        uint _goal,
        uint _durationInDays
    ) external payable {
        require(_recipient != address(0), "Recipient address cannot be zero");
        require(_recipientPublicKey.length == 33 || _recipientPublicKey.length == 65, "Invalid public key format");

        uint256 tokenId = nextTokenId++;
        _safeMint(msg.sender, tokenId);

        Campaign storage campaign = campaigns[tokenId];
        campaign.recipient = _recipient;
        campaign.recipientPublicKey = _recipientPublicKey;
        campaign.goal = _goal;
        campaign.deadline = block.timestamp + (_durationInDays * 1 days);

        emit CampaignCreated(tokenId, msg.sender, _recipient, _goal, campaign.deadline);
    }

    /**
     * @dev Allows users to contribute to a specific campaign.
     */
    function contribute(uint256 _tokenId, string memory _pseudonym) external payable {
        Campaign storage campaign = campaigns[_tokenId];
        require(block.timestamp < campaign.deadline, "Crowdfunding period has ended");
        require(msg.value > 0, "Contribution must be greater than 0");

        if (campaign.contributions[msg.sender] == 0) {
            campaign.contributors.push(msg.sender);
        }

        campaign.raisedAmount += msg.value;
        campaign.contributions[msg.sender] += msg.value;
        campaign.pseudonyms[msg.sender] = _pseudonym;

        emit ContributionMade(_tokenId, msg.sender, msg.value);
    }

    /**
     * @dev Allows the owner of the campaign (NFT holder) to withdraw funds.
     */
    function withdrawFunds(uint256 _tokenId, uint _amount) external {
        require(ownerOf(_tokenId) == msg.sender, "Only the campaign owner can withdraw funds");

        Campaign storage campaign = campaigns[_tokenId];
        require(_amount <= address(this).balance, "Insufficient contract balance");

        payable(campaign.recipient).transfer(_amount);

        emit FundsWithdrawn(_tokenId, campaign.recipient, _amount);
    }

    /**
     * @dev Withdraws all funds for a specific campaign.
     */
    function withdrawAllFunds(uint256 _tokenId) external {
        require(ownerOf(_tokenId) == msg.sender, "Only the campaign owner can withdraw funds");

        Campaign storage campaign = campaigns[_tokenId];
        require(address(this).balance > 0, "No funds available to withdraw");

        uint amountToWithdraw = address(this).balance;
        payable(campaign.recipient).transfer(amountToWithdraw);

        emit FundsWithdrawn(_tokenId, campaign.recipient, amountToWithdraw);
    }

    /**
     * @dev Renews a campaign by extending its deadline and optionally updating the goal.
     */
    function renewCampaign(
        uint256 _tokenId,
        uint _newDurationInDays,
        uint _newGoal
    ) external {
        require(ownerOf(_tokenId) == msg.sender, "Only the campaign owner can renew the campaign");

        Campaign storage campaign = campaigns[_tokenId];
        require(block.timestamp >= campaign.deadline, "Campaign is still active and cannot be renewed yet");

        // Update the goal if a new goal is provided
        if (_newGoal > 0) {
            campaign.goal = _newGoal;
        }

        // Extend the deadline
        campaign.deadline = block.timestamp + (_newDurationInDays * 1 days);

        emit CampaignRenewed(_tokenId, campaign.goal, campaign.deadline);
    }

    /**
     * @dev Returns the number of contributors for a specific campaign.
     */
    function getContributorsCount(uint256 _tokenId) public view returns (uint256) {
        return campaigns[_tokenId].contributors.length;
    }

    /**
     * @dev Returns the contributor at a specific index for a campaign.
     */
    function getContributorByIndex(uint256 _tokenId, uint index) public view returns (address) {
        Campaign storage campaign = campaigns[_tokenId];
        require(index < campaign.contributors.length, "Index out of bounds");
        return campaign.contributors[index];
    }

    /**
     * @dev Returns the pseudonym of a contributor for a specific campaign.
     */
    function getContributorPseudonym(uint256 _tokenId, address contributor) public view returns (string memory) {
        return campaigns[_tokenId].pseudonyms[contributor];
    }

    /**
     * @dev Checks if the goal of a campaign has been reached.
     */
    function hasGoalReached(uint256 _tokenId) public view returns (bool) {
        Campaign storage campaign = campaigns[_tokenId];
        return campaign.raisedAmount >= campaign.goal;
    }

    /**
     * @dev Returns the time left for a campaign.
     */
    function timeLeft(uint256 _tokenId) public view returns (uint) {
        Campaign storage campaign = campaigns[_tokenId];
        require(block.timestamp < campaign.deadline, "Crowdfunding period has ended");
        return campaign.deadline - block.timestamp;
    }
}