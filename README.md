# Functions and Errors

This Solidity program demonstrates the use of AVAX to create a game based on smart contracts.

## Description

The program features the minting, transferring, redeeming, checking, and burning of tokens. The `mint()` functions accepts an address and an amount to mint tokens to that specified address. The `getBalance()` function checks the balance of the sender address. The `transferTokens()` function transfers specified amount of tokens from an address to a receiving address. The `burnTokens()` burns tokens from the sender address. And lastly, the `redeemTokens()` function allows a user to purchase 4 items costing 10, 15, 45, and 55 tokens respectively.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., CreateToken.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    event TokensMinted(address indexed sender, address receiver, uint256 amount);
    event TokensTransferred(address indexed sender, address receiver, uint256 amount);
    event TokensBurned(address indexed id, uint256 amount);
    event TokensRedeemed(address indexed id, uint256 amount, uint8 item);

    function mint(address _receiver, uint256 _amount) public onlyOwner {
        _mint(_receiver, _amount);
        emit TokensMinted(msg.sender, _receiver, _amount);
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _amount) external {
        require(balanceOf(msg.sender) >= _amount, "You do not have enough Degen Tokens");
        approve(msg.sender, _amount);
        transferFrom(msg.sender, _receiver, _amount);
        emit TokensTransferred(msg.sender, _receiver, _amount);
    }

    function burnTokens(uint256 _amount) external {
        require(balanceOf(msg.sender) >= _amount, "You do not have enough Degen Tokens");
        _burn(msg.sender, _amount);
        emit TokensBurned(msg.sender, _amount);
    }

    function redeemTokens(uint8 _item) external {
        require(_item > 0 && _item < 5, "Item does not exist");
        uint8 amount = 0;
        if (_item == 1)
            amount = 10;
        if (_item == 2)
            amount = 15;
        if (_item == 3)
            amount = 45;
        if (_item == 4)
            amount = 55;
        _burn(msg.sender, amount);
        emit TokensRedeemed(msg.sender, amount, _item);
    }
}
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.9" or newer, and then click on the "Compile DegenToken.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the mint or burn function. You can also check the values of the public state variables by clicking on them.

## Authors

Adriane Gil Roa  


## License

This project is licensed under the MIT License - see the LICENSE file for details