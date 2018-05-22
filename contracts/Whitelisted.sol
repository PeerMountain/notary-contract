pragma solidity ^0.4.24;

import 'Ownable.sol'

contract Whitelisted is Ownable {

    constructor(_owner) public {
        owner = _owner;
    }

    mapping(address => bool) internal whitelistedAddresses;

    function isWhitelisted(address addr) internal view returns (bool) {
        return whitelistedAddresses[addr];
    }

    function addToWhitelist(address addr) public onlyOwner {
        require(!isWhitelisted(addr));
        whitelistedAddresses[addr] = true;
    }

    function removeFromWhitelist(address addr) public onlyOwner {
        require(isWhitelisted(addr));
        whitelistedAddresses[addr] = false;
    }

    modifier onlyWhitelisted {
        require(isWhitelisted(msg.sender));
        _;
    }
}
