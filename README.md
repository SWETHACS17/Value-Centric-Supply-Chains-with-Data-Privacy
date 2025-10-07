# ValueCentric — Privacy-Preserving Blockchain Supply Chain

ValueCentric revolutionizes supply chain management by creating a privacy-preserving blockchain ecosystem that allows transparent verification while protecting sensitive commercial data through zero-knowledge proof (ZKP) simulation.
It uses Solidity, OpenZeppelin-style AccessControl, and Ganache + Remix + MetaMask for development and testing.

## Features

-  Privacy-preserving verification using simulated ZK-SNARK proofs

-  Role-based access control for participants (Supplier, Manufacturer, Distributor, Retailer)

-  End-to-end traceability via blockchain event logs

-  On-chain commitments to simulate product verification

-  Lightweight simulation of ZKP to enable low-cost local testing

## Smart Contract Architecture
```bash
contracts/
│
├── AccessControl.sol      # Custom role management base contract
└── ValueCentric.sol       # Main supply chain + ZKP simulation contract
```
🔸 Participants
- Role	Description
- Supplier	Creates new product commitments
- Manufacturer	Receives and transforms products
- Distributor	Handles product logistics
- Retailer	Final endpoint for product delivery

🔸 Core Functions

Function                                                 	Description
registerParticipant(bytes32 role, address account)	 -  Assigns a role to an account
computeCommitment(string secret, uint256 productId)	-  Simulates a ZK commitment using keccak256
createProduct(uint256 productId, bytes32 commitment)	-  Supplier creates a product
transferProduct(uint256 productId, address to, bytes zkProof) -	Transfers product along supply chain
hasRole(bytes32 role, address account)	- Verifies participant role
getProductOwner(uint256 productId) -	Returns current owner
getCommitment(uint256 productId) -	Returns commitment hash

## Prerequisites

1. Install Ganache
2. Setup MetaMask
3. Open Remix IDE
4. Compilation
5. Deployment

```bash
registerParticipant(keccak256("SUPPLIER"), 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)
registerParticipant(keccak256("MANUFACTURER"), 0xAbCDEF1234567890...)
registerParticipant(keccak256("DISTRIBUTOR"), 0x2B3C4D5E6F7G8H9I...)
registerParticipant(keccak256("RETAILER"), 0x9d077440acc3a289671f47bcB8a4d2d44B9D82B5)

```
## Working of the ValueCentric Blockchain System
### Blockchain Block Creation in Ganache
- Displays the block creation process on the local Ganache blockchain network, confirming successful transaction mining for the ValueCentric system.
<br></br>
![WhatsApp Image 2025-10-07 at 08 49 52_e8a4ce21](https://github.com/user-attachments/assets/b173654e-89c1-4b32-8b84-d86866bfcb55)

### Smart Contract Creation Status in Ganache
- Shows the details of a single block containing the smart contract creation transaction, verifying successful deployment and contract address generation.
<br></br>
![WhatsApp Image 2025-10-07 at 08 49 59_35da65f2](https://github.com/user-attachments/assets/8fc2a30d-e976-41ab-afef-3cab8c3fd34c)
