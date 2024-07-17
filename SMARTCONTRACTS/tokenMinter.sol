// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// ____________________________________________________________
// deployed on sepolia 0xAB94891852f2358145738f11D118CbD8af994f1e
// ____________________________________________________________
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";


// 0jbjetivo: crear un smart contract erc 20 compatible en solidity que sea transmitible con permit(o sea con firmas offchain), y en el cual cada usuario pueda mintear hasta 1480 tokens por dia, y estos tokens solo pueden crearse si estan validados por otro usuario de la red que tenga el rol "validated" 
// PROP
// pasos:
// Implementar el estándar ERC-20.
// Implementar el mecanismo permit.
// Agregar una función de minteo con límites diarios.
// Asegurar que los tokens se pueden mintear solo si son validados por un usuario con el rol "validated".

contract trokTokenMinter is ERC20, AccessControl, ERC20Permit {
    using ECDSA for bytes32;
    using Counters for Counters.Counter;

    bytes32 public constant VALIDATOR_ROLE = keccak256("VALIDATOR_ROLE");
    uint256 public constant MAX_MINT_AMOUNT = 1440 * (10 ** 18); // Adjusted to 1440 tokens per day

    mapping(address => uint256) public lastMintTimestamp;
    // mapping(address => Counters.Counter) public nonces;
        mapping(address => Counters.Counter) private _mintNonces;


    constructor() ERC20("TrokToken", "TROK") ERC20Permit("TrokToken") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);


    }

    function mint(address to, uint256 amount, bytes memory signature) public {
        require(hasRole(VALIDATOR_ROLE, msg.sender), "Caller is not a validator");
        require(amount <= MAX_MINT_AMOUNT, "Mint amount exceeds daily limit");
        require(block.timestamp - lastMintTimestamp[to] >= 1 days, "Minting too soon");
    
    
    // VERIFY THE SIGNATURE
        bytes32 messageHash = keccak256(abi.encodePacked(to, amount, _mintNonces[to].current()));
        bytes32 ethSignedMessageHash = MessageHashUtils.toEthSignedMessageHash(messageHash);
        
        // bytes32 ethSignedMessageHash = ECDSA.toEthSignedMessageHash(messageHash);

        address signer = ECDSA.recover(ethSignedMessageHash, signature);

 


        require(hasRole(VALIDATOR_ROLE, signer), "Signature is not from a validator");

        lastMintTimestamp[to] = block.timestamp;
        // nonces[to].increment();
        _mintNonces[to].increment(); // Increment the nonce for the 'to' address

        _mint(to, amount);
    }

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public override {
        super.permit(owner, spender, value, deadline, v, r, s);
    }

    function getMintNonce(address account) public view returns (uint256) {
        return _mintNonces[account].current();
    }
}
