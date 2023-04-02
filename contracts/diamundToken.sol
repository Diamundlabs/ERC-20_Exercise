// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
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
}
