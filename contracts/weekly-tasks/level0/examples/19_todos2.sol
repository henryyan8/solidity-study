//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "./18_struct_declaration.sol";

struct Todos {
    Todo[] public todos;
}