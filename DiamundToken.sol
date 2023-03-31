
// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract DiamundToken {
    string public name = "Diamund Token";
    string public symbol = "DMDT";
    uint256 public decimals = 18;
    uint256 _totalSupply  = 1_000_000_000 * 10 ** decimals;
    mapping(address => uint256) balances;
    address public owner;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor(address _recipient) {
        owner = msg.sender;
        balances[owner] = _totalSupply  / 2;
        balances[_recipient] = _totalSupply  / 2;
    }

    function transfer(address _recipient, uint256 amount) external returns (bool) {
        require(msg.sender != address(0), "transfer from the zero address");
        require(_recipient != address(0), "transfer to the zero address");
        require(balances[msg.sender] >= amount, "transfer amount exceeds balance");
        balances[msg.sender] -= amount;
        balances[_recipient] += amount;
        emit Transfer(msg.sender, _recipient, amount);
        return true;
    }

    function balanceOf(address _account) external view returns (uint256) {
        return balances[_account];
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply ;
    }
    
}
