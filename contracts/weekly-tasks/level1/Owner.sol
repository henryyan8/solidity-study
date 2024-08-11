// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Owner {
    struct Identity {
        address addr;
        string name;
    }

    enum State {
        HasOwner,
        NoOwner
    }

    event OwnerSet(address indexed oldOwnerAddr,address indexed newOldAddr);
    event OwnerRemove(address indexed oldOwnerAddr);

    modifier isOwner() {
        require(msg.sender==owner.addr,"Caller is not owner");
        _;
    }
    Identity private owner;
    State private state;

    //构造函数
    constructor(string memory name){
        owner.addr=msg.sender;
        owner.name=name;
        state=State.HasOwner;
        emit OwnerSet(address(0), owner.addr);
    }

    //普通函数
    function changeOwner(address addr,string calldata name) public isOwner{
        emit OwnerSet(owner.addr, addr);
        owner.addr=addr;
        owner.name=name;
    }

    function removeOwner() public isOwner{
        emit OwnerRemove(owner.addr);
        delete owner;
        state=State.NoOwner;
    }

    function getOwner() external view returns(address,string memory){
        return (owner.addr,owner.name);
    }

    function getState() external view returns(State){
        return state;
    }

}