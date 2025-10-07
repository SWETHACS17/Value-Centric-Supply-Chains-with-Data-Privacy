// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./oz/AccessControl.sol";

/**
 * @title ValueCentric
 * @dev Simulated privacy-preserving supply chain contract using role-based access control
 */
contract ValueCentric is AccessControl {
    // Define supply chain roles
    bytes32 public constant SUPPLIER_ROLE = keccak256("SUPPLIER_ROLE");
    bytes32 public constant MANUFACTURER_ROLE = keccak256("MANUFACTURER_ROLE");
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR_ROLE");
    bytes32 public constant RETAILER_ROLE = keccak256("RETAILER_ROLE");

    struct Product {
        uint256 id;
        string name;
        string batchNumber;
        address currentOwner;
        bool verified;
    }

    uint256 private _nextProductId;
    mapping(uint256 => Product) private _products;

    event ProductCreated(uint256 indexed id, string name, string batchNumber, address indexed creator);
    event OwnershipTransferred(uint256 indexed id, address indexed from, address indexed to);
    event ProductVerified(uint256 indexed id, bool verified, string proof);

    constructor() {
        // The deployer gets the admin and supplier role by default
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(SUPPLIER_ROLE, msg.sender);
    }

    // Supplier creates a product
    function createProduct(string memory name, string memory batchNumber)
        external
        onlyRole(SUPPLIER_ROLE)
    {
        uint256 productId = ++_nextProductId;

        _products[productId] = Product({
            id: productId,
            name: name,
            batchNumber: batchNumber,
            currentOwner: msg.sender,
            verified: false
        });

        emit ProductCreated(productId, name, batchNumber, msg.sender);
    }

    // Transfer ownership between supply chain roles
    function transferOwnership(uint256 productId, address newOwner)
        external
    {
        Product storage product = _products[productId];
        require(product.currentOwner == msg.sender, "Not product owner");
        require(newOwner != address(0), "Invalid new owner");

        address previousOwner = product.currentOwner;
        product.currentOwner = newOwner;

        emit OwnershipTransferred(productId, previousOwner, newOwner);
    }

    // Simulated zero-knowledge proof verification
    function verifyProduct(uint256 productId, string memory zkProof)
        external
        onlyRole(MANUFACTURER_ROLE)
    {
        Product storage product = _products[productId];
        product.verified = true;

        emit ProductVerified(productId, true, zkProof);
    }

    // View details
    function getProduct(uint256 productId)
        external
        view
        returns (Product memory)
    {
        return _products[productId];
    }
}
