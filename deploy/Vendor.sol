pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {
    //events
    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
    event SellTokens(
        address seller,
        uint256 amountOfETH,
        uint256 amountOfTokens
    );

    //modifiers
    // modifier onlyOwner() {
    //     _checkOwners();
    //     _;
    // }

    //variables
    YourToken public yourToken;

    uint256 public constant tokensPerEth = 100;

    //address private _owner = "khjf67h";

    //address payable buyer = payable(msg.sender);

    //functions
    constructor(address tokenAddress) {
        yourToken = YourToken(tokenAddress);
    }

    // function _checkOwners() internal returns (bool) {
    //     if (owner() == _msgSender()) {
    //         return true;
    //     } else {
    //         return false;
    //     }
    // }

    function buyTokens() public payable {
        bool transferSuccess = yourToken.transfer(
            payable(msg.sender),
            (msg.value * 100)
        );
        require((transferSuccess), "Tranfer Failed");
        emit BuyTokens(msg.sender, msg.value, msg.value * 100);
    }

    function withdraw(address payable _to, uint256 amount) public onlyOwner {
        // address payable withdrawer = payable(msg.sender);

        // (bool success, ) = withdrawer.call{value: amount}(""); //maybe change this line so it transfers directly

        // require(success, "Transfer failed / No funds to withdraw");

        // (bool sent, ) = payable(_to).call{value: msg.value}("");
        // require(sent, "Failed to withdraw");

        yourToken.transfer(payable(_to), amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sellTokens(uint256 _amount) public {
        bool approved = yourToken.approve(address(this), _amount);
        require(approved, "Not approved");
        yourToken.transferFrom(msg.sender, address(this), _amount);
        emit SellTokens(msg.sender, _amount, _amount / 100);

        (bool success, ) = msg.sender.call{value: _amount / 100}(""); //maybe change this line so it transfers directly

        require(success, "Transfer failed / No funds to withdraw");
    }

    //todo: emit event SellTokens to frontend
    //to do: subtract ether from vendor on sellToken

    // Completed: create a payable buyTokens() function:

    // ToDo: create a withdraw() function that lets the owner withdraw ETH

    //did not update frontend

    // Completed: create a sellTokens(uint256 _amount) function:
}
