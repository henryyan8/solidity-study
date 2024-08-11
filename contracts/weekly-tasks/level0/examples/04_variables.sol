//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract Variables {
    //state
    string public text="hello";
    uint public num=123;

    function doSomething() public {
        //local
        uint256 i=456;

        //global
        uint256 timestamp=block.timestamp;
        address sender=msg.sender;
    }

}