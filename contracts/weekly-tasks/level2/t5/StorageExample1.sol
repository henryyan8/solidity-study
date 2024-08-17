// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract StorageExample1 {
    uint8 public a = 11;
    uint256 b = 12;
    uint256[2] c = [13, 14];
    struct Entry {
        uint256 id;
        uint256 value;
    }
    Entry d;
}
