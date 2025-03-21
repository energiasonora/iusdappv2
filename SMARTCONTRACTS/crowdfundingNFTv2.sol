// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// deployed arb sepolia: 0xdBb4792aa73aC4938F5BF05a109CC851Bd906250

// how it works
// sender registers their public key by calling the registerPublicKey function 
// before creating a campaign.
// Generate the required signature off-chain using  ethers.js.
// Pass the generated signature to the registerPublicKey function.
// Once the public key is registered, the createCampaign function will succeed.


// DEPLOY EXAMPLE
// (0.33 eth in wei 330000000000000000)

// recipient : 0x2491207eA01b4EFd267690F11aA17BE6c2d70072
// pubKey: 0x0497eab0841786aeae14135af5e26750626e46e2e15a412b6a319dd2ce7f323c805d67fcfb0f8ea1f27959e486e11e49926fbf4b1c2b9252daa20283e200e3b1b3
// _GOAL: 330000000000000000
// _DURATIONINDAYS: 33




contract CrowdfundingNFTv2 is ERC721, Ownable {
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
    event CampaignCreated(uint256 indexed tokenId,   address indexed recipient, uint goal, uint deadline);
    // event CampaignCreated(uint256 indexed tokenId, address indexed creator, address indexed recipient, uint goal, uint deadline);
    // event ContributionMade(uint256 indexed tokenId, address indexed contributor, uint amount);
    event ContributionMade(
    uint256 indexed tokenId,
    address indexed contributor,
    uint amount,
    bool useStealthAddress
);
event PublicKeyRegistered(
    address indexed user,
    bytes publicKey
);
    event FundsWithdrawn(uint256 indexed tokenId, address indexed recipient, uint amount);
    event CampaignRenewed(uint256 indexed tokenId, uint newGoal, uint newDeadline);

    /**
     * @dev Constructor initializes the ERC721 and Ownable contracts.
     */
    constructor() ERC721("CrowdfundingNFT", "CFNFT") Ownable(msg.sender) {}


// Mapping to store public keys associated with addresses
mapping(address => bytes) public publicKeyMap;

/**
 * @dev Allows users to register their public key by deriving it from the transaction signature.
 */
// function registerPublicKey() external {
//     // Derive the public key from the transaction signature
//     bytes memory publicKey = recoverPublicKey();
// // bytes32 msgHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", keccak256(abi.encodePacked(msg.sender))));
// // bytes memory publicKey = recoverPublicKey(msgHash);
//     // Store the public key in the mapping
//     publicKeyMap[msg.sender] = publicKey;

//     emit PublicKeyRegistered(msg.sender, publicKey);
// }

function registerPublicKey(bytes memory _signature) external {
    // Compute the message hash
    bytes32 msgHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", keccak256(abi.encodePacked(msg.sender))));

    // Recover the public key
    address signer = recoverPublicKey(_signature, msgHash);
    require(signer == msg.sender, "Invalid signature");

    // Store the public key in the mapping
    publicKeyMap[msg.sender] = abi.encodePacked(signer);

    emit PublicKeyRegistered(msg.sender, abi.encodePacked(signer));
}

/**
 * @dev Recovers the public key from the transaction signature.
 */
 function recoverPublicKey(bytes memory _signature, bytes32 _hash) internal pure returns (address) {
    // Split the signature into r, s, and v components
    bytes32 r;
    bytes32 s;
    uint8 v;

    // Extract r, s, and v from the signature
    assembly {
        r := mload(add(_signature, 32))
        s := mload(add(_signature, 64))
        v := byte(0, mload(add(_signature, 96)))
    }

    // Recover the signer's address using ecrecover
    return ecrecover(_hash, v, r, s);
}
// function recoverPublicKey() internal view returns (bytes memory) {
//     // Compute the message hash internally
//     bytes32 msgHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", keccak256(abi.encodePacked(msg.sender))));

//     // Recover the public key using ecrecover
//     bytes32 r;
//     bytes32 s;
//     uint8 v;
//     assembly {
//         r := mload(add(msg.data, 32))
//         s := mload(add(msg.data, 64))
//         v := byte(0, mload(add(msg.data, 96)))
//     }
//     address signer = ecrecover(msgHash, v, r, s);
//     require(signer == msg.sender, "Invalid signature");

//     return abi.encodePacked(signer); // Placeholder for actual public key recovery
// }


/**
 * @dev Creates a new crowdfunding campaign and mints an NFT for it.
 */
function createCampaign(
    uint _goal,
    uint _durationInDays
) external payable {
    require(_goal > 0, "Goal must be greater than zero");
    require(_durationInDays > 0, "Duration must be greater than zero");

    // Automatically assign the sender as the recipient
    address recipient = msg.sender;

    // Fetch the recipient's public key from contributorsthe mapping
    // bytes memory recipientPublicKey = publicKeyMap[recipient];
    bytes memory recipientPublicKey; // Declare here
    recipientPublicKey = publicKeyMap[recipient]; // Assign later
    require(recipientPublicKey.length > 0, "Public key not registered");

    // Mint the NFT to the sender
    uint256 tokenId = nextTokenId++;
    _safeMint(recipient, tokenId);

    // Store campaign details
    Campaign storage campaign = campaigns[tokenId];
    campaign.recipient = recipient;
    campaign.recipientPublicKey = recipientPublicKey;
    campaign.goal = _goal;
    campaign.deadline = block.timestamp + (_durationInDays * 1 days);

    // Emit the event
    emit CampaignCreated(tokenId, recipient, _goal, campaign.deadline);
}

/**
 * @dev Allows users to contribute to a specific campaign.
 *      Contributions can optionally be sent to a stealth address.
 */


 
function contribute(uint256 _tokenId, string memory _pseudonym, bool _useStealthAddress) external payable {
    Campaign storage campaign = campaigns[_tokenId];
    require(block.timestamp < campaign.deadline, "Crowdfunding period has ended");
    require(msg.value > 0, "Contribution must be greater than 0");

    // Record contribution details
    if (campaign.contributions[msg.sender] == 0) {
        campaign.contributors.push(msg.sender);
    }
    campaign.raisedAmount += msg.value;
    campaign.contributions[msg.sender] += msg.value;
    campaign.pseudonyms[msg.sender] = _pseudonym;

    // Determine the recipient addresscontributors
    address recipient;
    if (_useStealthAddress) {
        // Fetch the recipient's public key
        bytes memory recipientPublicKey = publicKeyMap[campaign.recipient];
        require(recipientPublicKey.length > 0, "Recipient public key not registered");

        // Derive the stealth address off-chain (placeholder for actual derivation)
        recipient = deriveStealthAddress(recipientPublicKey);
    } else {
        // Default to the campaign creator's contributorsaddress
        recipient = campaign.recipient;
    }

    // Transfer funds to the recipient (stealcontributorsth address or campaign creator)
    (bool success, ) = recipient.call{value: msg.value}("");
    require(success, "Transfer failed");

    emit ContributionMade(_tokenId, msg.sender, msg.value, _useStealthAddress);
}

function deriveStealthAddress(bytes memory _recipientPublicKey) internal pure returns (address) {
    // Placeholder: Return a dummy address for demonstration purposes.
    return address(uint160(uint256(keccak256(_recipientPublicKey))));
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
     * @dev Returns the contributor at a speccontributorsific index for a campaign.
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