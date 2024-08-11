//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract Loop {
    function loop() public{
        for(uint256 i=0;i<10;i++){
            if(i==3){
                continue;
            }
            if(i==5){
                break;
            }
        }

        uint256 j;
        while(j<10){
            j++;
        }
    }
}