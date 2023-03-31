// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract DiamundToken {
    string public name = "Diamund Token";
    string public symbol = "DMDT";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000000 * 10 ** uint256(decimals);
    address public owner;

    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private allowed;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(address _recipient) {
        owner = msg.sender;
        balances[owner] = totalSupply  / 2;
        balances[_recipient] = totalSupply  / 2;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value);
        require(_to != address(0));
        
        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

}
