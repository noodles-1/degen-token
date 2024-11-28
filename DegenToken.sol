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