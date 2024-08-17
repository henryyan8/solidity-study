// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract StorageExample2 {
    uint256 a = 11; // 插槽 0
    uint8 b = 12; // 插槽1，1 字节
    uint128 c = 13; // 插槽1，16 字节
    bool d = true; // 插槽1，1 字节
    uint128 e =  14;//插槽2
}