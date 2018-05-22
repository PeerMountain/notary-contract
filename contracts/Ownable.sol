pragma solidity ^0.4.24;

contract Ownable {
    address owner;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
}