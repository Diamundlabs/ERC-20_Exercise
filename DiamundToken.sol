// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**@title DiamundToken ERC20 Excercise
 * @author Daniel Osariemen Osazee
 * @dev This contract implements the EIP-20 standard 
 */


contract ERC20 {
    //    EIP-20 Standard has the following functions and events
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