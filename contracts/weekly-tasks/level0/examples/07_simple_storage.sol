//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract SimpleStorage {
    uint256 public num;
    
    function set(uint256 _num) public {
        num=_num;
    }

    function get() public view returns(uint256){
        return num;
    }
}