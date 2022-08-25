pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20 {
    //state variables
    // uint256 public constant tokensPerEth = 100;
    // address payable buyer = payable(msg.sender);

    //events

    //functions
    constructor() ERC20("Gold", "GLD") {
        _mint(msg.sender, 1000 * 10**18);
        //transfer(msg.sender, 1000);
        // require((transferSuccess), "Tranfer Failed");
    }

    // function buyTokens(uint256 amount) public payable {
    //     bool transferSuccess = transfer(buyer, amount);
    //     require((transferSuccess), "Tranfer Failed");
    // }

    // 1) transfer to msg.sender
    // 2) transfer to Vendor.address
}
