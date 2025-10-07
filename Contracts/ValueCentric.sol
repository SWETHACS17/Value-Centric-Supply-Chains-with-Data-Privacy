// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * Minimal OpenZeppelin AccessControl for local testing
 */
contract AccessControl {
    mapping(bytes32 => mapping(address => bool)) internal _roles;
    mapping(bytes32 => bytes32) internal _roleAdmins;

    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    constructor() {
        _roles[DEFAULT_ADMIN_ROLE][msg.sender] = true;
    }

    modifier onlyRole(bytes32 role) {
        require(hasRole(role, msg.sender), "AccessControl: account missing role");
        _;
    }

    function hasRole(bytes32 role, address account) public view returns (bool) {
        return _roles[role][account];
    }

    function getRoleAdmin(bytes32 role) public view returns (bytes32) {
        return _roleAdmins[role];
    }

    function grantRole(bytes32 role, address account) public onlyRole(getRoleAdmin(role)) {
        _roles[role][account] = true;
        emit RoleGranted(role, account, msg.sender);
    }

    function revokeRole(bytes32 role, address account) public onlyRole(getRoleAdmin(role)) {
        _roles[role][account] = false;
        emit RoleRevoked(role, account, msg.sender);
    }

    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal {
        _roleAdmins[role] = adminRole;
    }
}
