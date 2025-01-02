// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract MiracleGameEvent is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    event RegisterScore(
        uint256 indexed yyyymmdd,
        string indexed gameUid,
        string scoreData,
        uint256 timestamp
    );

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);
    }

    function grantAdminRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(ADMIN_ROLE, account);
    }

    function revokeAdminRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _revokeRole(ADMIN_ROLE, account);
    }

    function registerScore(
        uint256 yyyymmdd,
        string memory _gameUid,
        string memory _scoreData
    ) external onlyRole(ADMIN_ROLE) {
        require(yyyymmdd >= 19000101 && yyyymmdd <= 99991231, "Invalid date format");
        require(bytes(_gameUid).length > 0, "GameUid cannot be empty");
        require(bytes(_scoreData).length > 0, "ScoreData cannot be empty");
        
        emit RegisterScore(yyyymmdd, _gameUid, _scoreData, block.timestamp);
    }
}
