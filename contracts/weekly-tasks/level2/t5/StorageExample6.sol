// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract StorageExample6 {
    uint256 a = 11;
    uint8 b = 12;
    uint128 c = 13;
    bool d = true;
    uint128 e =  14;
    uint256[] public array =  [401,402,403,405,406];

    address owner;
    mapping(address => UserInfo) public users;
    string  str="name value";

    struct UserInfo {
        string name;
        uint8 age;
        uint8 weight;
        uint256[] orders;
        uint64[3] lastLogins;
    }

   constructor() {
       owner=msg.sender;

       addUser(owner,"admin",17,120);
   }

   function addUser(address user,string memory name,uint8 age,uint8 weight) public {
       require(age>0 && age <100 ,"bad age");

       uint256[] memory orders;
       uint64[3] memory logins;

       users[user] = UserInfo({
           name: name, age:    age,  weight:weight,
           orders:orders,  lastLogins:logins
       });
   }
   function addLog(address user,uint64 id1,uint64 id2,uint64 id3) public{
       UserInfo storage u = users[user];
       assert(u.age>0);

       u.lastLogins[0]=id1;
       u.lastLogins[1]=id2;
       u.lastLogins[2]=id3;
   }

   function addOrder(address user,uint256 orderID) public{
       UserInfo storage u = users[user];
       assert(u.age>0);
       u.orders.push(orderID);
   }
   function getLogins(address user) public view returns (uint64,uint64,uint64){
        UserInfo storage u = users[user];
       return  (u.lastLogins[0],u.lastLogins[1],u.lastLogins[2]);
   }
   function getOrders(address user) public view returns (uint256[] memory){
        UserInfo storage u = users[user];
       return  u.orders;
   }
}