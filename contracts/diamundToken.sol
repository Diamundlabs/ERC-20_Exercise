// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function findBalance(address owner) external view returns (uint256);

    function transferToken(
        address _receiver,
        uint value
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract Exercise_ERC20 is IERC20 {
    constructor(address recipient) {
        // assigned half of supply tokens to contract owner
        balance[msg.sender] = totalSupply / 2;

        // assigned half of supply tokens to recipient which will be provided before deploying contract
        balance[recipient] = totalSupply / 2;
    }

    uint256 public totalSupply = 1000000000 * 1 ** 18;
    string public tokenSymbol = "DMDT";
    string public tokenName = "Diamond Token";

    // maps address to balance of tokens
    mapping(address => uint256) balance;

    // Get total supply of tokens
    function _totalSupply() public view returns (uint256 total) {
        total = totalSupply;
    }

    // Find DMDT Balance of an address
    function findBalance(
        address owner
    ) public view returns (uint256 balanceOwner) {
        balanceOwner = balance[owner];
    }

    // Transfer DMDT Tokens from one address to another
    function transferToken(
        address _receiver,
        uint value
    ) public returns (bool) {
        require(balance[msg.sender] >= value, "Insufficient Funds");
        balance[msg.sender] = balance[msg.sender] - value;
        balance[_receiver] = balance[_receiver] + value;

        emit Transfer(msg.sender, _receiver, value);

        return true;
    }
}
