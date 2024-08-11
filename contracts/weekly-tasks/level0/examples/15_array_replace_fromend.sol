//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract ArrayReplaceFromEnd {
    uint256[] public arr;
    function remove(uint256 index) public{
        require(index<arr.length,"index out of bound");
        arr[index]=arr[arr.length-1];
        arr.pop();
    }
    function test() public{
        arr=[1,2,3,4];
        remove(1);
        assert(arr.length==3);
        assert(arr[0]==1);
        assert(arr[1]==4);
        assert(arr[2]==3);

        remove(2);
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}