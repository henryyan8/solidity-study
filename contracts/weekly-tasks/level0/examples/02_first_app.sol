//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract Counter {
    uint256 public count;
    
    function get() public view returns(uint256){
        return count;
    }

    function inc() public {
        count+=1;
    }

    function dec() public {
        count-=1;
    }
}