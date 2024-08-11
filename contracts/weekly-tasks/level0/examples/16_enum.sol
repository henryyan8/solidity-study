//Here is a simple contract that you can get,increment and decrement the count store in this contract
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract Enum {
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    Status public status;

    function get() public view returns (Status) {
        return status;
    }

    function set(Status _status) public {
        status=_status;
    }

    function cancel() public {
        status=Status.Canceled;
    }

    function reset() public {
        delete status;
    }
}