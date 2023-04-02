# ERC20 Smart Contract

## Steps

- I stated with cloning the repo that was setup for this test
- Created the solidity file
- At the part of the code, I created an interface that describes my contract a s an ERC20 contract. Although I would have preferred importing the ERC-20 token standard from OZ rather than writing it from scratch.
  But this is for a better understanding of solidity.
- I initialized a constructor that will help to input the recipient address so that the owner of the address will have half of the total supply of my ERC20 tokens. The other half goes to the contract owner
- I then proceeded to write functions to check tht total balance of my tokens, to help check the ERC20 tokens of an address.
- I added comments as I writing my smart contract to help even a newbie or a someone who does't understand solidity in understanding what my smart contract does.

### Compilation and Deployment
- I then compiled my smart contract using Remix, to check for any errors either syntax or logic;
- I then chose an environment (locally) to deploy my smart contract and then test out the functions in my contract.
