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
        // Make sure user's transfer's are less than or equal to the amount allowed by them
        allowance[_sender][msg.sender] -= _amount;

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
=======

pragma solidity ^0.8.0;

/**@title DiamundToken ERC20 Excercise
 * @author Daniel Osariemen Osazee
 * @dev This contract implements the EIP-20 standard 
 */


contract DiamundToken {
    //     FUNCTIONS
    //      *   totalSupply()
    //      *   balanceOf(account)
    //      *   transfer(recipient, amount)
    //      *   allowance(owner, spender)
    //      *   approve(spender, amount)
    //      *   transferFrom(sender, recipient, amount)
    
    //     EVENTS
    //      *   Transfer(from, to, value)
    //      *   Approval(owner, spender, value)


    /** 
    * @dev Events
    */
    event Transfer(
        address from, 
        address to, 
        uint256 value
        );

    event Approval(
        address owner, 
        address spender, 
        uint256 value
        );

    

    /** 
    * @dev Variable Declaration
    */
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply = 1000000000 ether;
    address public immutable recipient;
    address public immutable deployer;


    /** 
    * @dev Mappings
    */
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;

    /** 
    * @dev Constructor
    */
    constructor (address _recipient) {
        name = "Diamund Token";
        symbol = "DMDT";
        decimals = 18;
        deployer = msg.sender;
        recipient = _recipient;
        
        // Give the owner 50% the totalsupply 
        balances[deployer] = totalSupply / 2;

        // Give the recipient 50% the totalsupply
        balances[recipient] = totalSupply / 2;

    }

     /** 
    * @dev -------- Main Functions --------
    */

    /** 
    * @dev Approve token value for spending
    */
    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Invalid address");
        success = true;
       
        allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
    }
    

    /** 
    * @dev Transfer function: enables transfer of token
    */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value, "No enough token");
        require(_to != address(0), "Invalid address");
        success = true;

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);        
    }

    /** 
    * @dev Transfer From function: allows transfer on behalf of another
    */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(allowances[_from][msg.sender] >= _value, "Not Enough Allowance");
        require(balances[_from] >= _value, "No enough token");
        require(_to != address(0), "Invalid address");
        success = true;
       
        // reduce allowance
        allowances[_from][msg.sender] -= _value;

        balances[_from] -= _value;
        balances[_to] += _value;

        emit Transfer(_from, _to, _value);
    }


    /** 
    * @dev ---- Getter Functions ------
    */

    /** 
    * @dev Balance Of
    */
    function balanceOf(address _owner) public view returns (uint256 balance){
        balance = balances[_owner];
    }

    /** 
    * @dev get deployer balance
    */
    function getDeployerBalance () public view returns(uint256 balance) {
        return balances[deployer];
    }

    /** 
    * @dev get recipient balance
    */
    function getRecipientBalance () public view returns(uint256 balance) {
        return balances[recipient];
    }

    /** 
    * @dev get allowance
    */
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowances[_owner][_spender];
    }
    


}
