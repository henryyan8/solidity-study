// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract StorageExample5 {
    mapping(string => uint256) a;

    constructor() {
        a["u1"] = 18;
        a["u2"] = 19;
    }
}
