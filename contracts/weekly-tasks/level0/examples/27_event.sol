//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "./18_struct_declaration.sol";

contract Event {
    event Log(address indexed sender,string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender,"Hello World");
        emit Log(msg.sender,"Hello EVM!");
        emit AnotherLog();
    }
}