//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract Immutable {
    address public immutable MY_ADDRESS;

    uint256 public immutable MY_UINT;

    constructor(uint256 _myuint){
        MY_ADDRESS=msg.sender;
        MY_UINT=_myuint;
    }
}