// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**@title DiamunToken ERC20 Excercise
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

    


}