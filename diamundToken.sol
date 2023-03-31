// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract DiamundToken {
    string private _name = "Diamund Token";
    string private _symbol = "DMDT";
    uint256 private _decimal = 18;
    uint256 private _totalSupply = 1000000000;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) approved;

    // Event
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    constructor() public {
        address deployer = msg.sender; // deployer address;
        address recipient = 0xD8CE2194a6a83557451fA6A90fa20ab9f996307e; // recipient address;
        // address recipient2 = 0x522a6fC6203E4a038A9B529c6E9520b399748e05; // recipient address;

        balances[deployer] = totalSupply() / 2; // deployer takes 50%
        balances[recipient] = totalSupply() / 2; // recipient takes 50%

        emit Transfer(address(0), deployer, totalSupply() / 2);
        emit Transfer(address(0), recipient, totalSupply() / 2);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return 18;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balances[msg.sender] >= _value, "Insufficient Balance");

        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;

        emit Transfer(msg.sender, _to, _value);
        success = true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 approvedBalance = approved[_from][msg.sender];
        require(approvedBalance <= _value, "You dont't have access");

        balances[_from] = balances[_from] - _value;
        approved[_from][msg.sender] = approved[_from][msg.sender] - _value;

        balances[_to] = balances[_to] + _value;

        emit Transfer(_from, _to, _value);
        success = true;
    }

    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        approved[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        success = true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining) {
        remaining = approved[_owner][_spender];
    }
}
