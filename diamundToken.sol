// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract DiamondToken is IERC20 {

    // Stores balances {address => uint}
    mapping(address => uint) public balanceOf;

    // Stores allowances {address => uint}
     
    mapping(address => mapping(address => uint)) public allowance;

    // Returns the `name`{string} of the token.
     
    string public name = "Diamund Token";

    
    // Returns the `symbol`{string} of the token.
     
    string public symbol = "DMDT";

    
    // Returns the `decimals`{uint} of the token.
     
    uint8 public decimals = 18;

    // Returns the `deployer's`{address} address.
     
    address public delpoyer;    

    
    // Returns the `recipient`{addresss} of the contact.
     
    address public recipient;

    
    // Returns the `total supply`{uint} of the token.
     
    uint public totalSupply = 1000000000;

    /**
     * @dev Returns executes runtime configurations.
     * Requirements
     * - `_initialrecipient` {address} recipients address
     */

    constructor(address _initialrecipient) {
        
        //  Store `Initial Supply` {number} of the token
         
        uint initialSupply = totalSupply;

        
        // set's the deployer of the contract to the executor's{address}
         
        delpoyer = msg.sender;

        
        // set's the recepient of the contract to the adress set on execution {address}
        

        recipient = _initialrecipient;
        
         // set's the deployer's balance
         

        balanceOf[msg.sender] += initialSupply / 2;
        
        // increases the total supply of the contract
         
        
        totalSupply += initialSupply / 2;
        
        // emits the transfer protocol
         
        emit Transfer(address(0), msg.sender, initialSupply / 2);

        // set recepient's balance to new balance
        
        balanceOf[_initialrecipient] += initialSupply / 2;

        
        // increases the total supply of the contract
         

        totalSupply += initialSupply / 2;

        // emits the transfer protocol
        emit Transfer(address(0), _initialrecipient, initialSupply / 2);
    }

    

    function transfer(address _recipient, uint _amount) external returns (bool) {
        // Make sure user's are unable to send transactions to themselves
        require(msg.sender != _recipient, "Sender and receiver cannot have same address");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_recipient] += _amount;
        emit Transfer(msg.sender, recipient, _amount);
        return true;
    }

    function approve(address _spender, uint _amount) external returns (bool) {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function transferFrom(
        address _sender,
        address _recipient,
        uint _amount
    ) external returns (bool) {

        // Make sure user's are unable to send transactions to themselves

        require(_sender != _recipient, "Sender and receiver cannot have same address");
        balanceOf[_sender] -= _amount;
        balanceOf[_recipient] += _amount;
        emit Transfer(_sender, recipient, _amount);
        return true;
    }

    function mint(uint _amount) external {
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
        emit Transfer(address(0), msg.sender, _amount);
    }

    function burn(uint _amount) external {
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Transfer(msg.sender, address(0), _amount);
    }
}
