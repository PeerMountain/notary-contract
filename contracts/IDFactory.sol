pragma solidity ^0.4.24;

import'./ID.sol'
import'./Whitelisted.sol'

contract idFactory is Ownable {

    Whitelisted whitelist;

    event IDCreated(uint id, address idContractAddress);

    mapping (uint => address) public ids;

    modifier idExists(uint id) {
      require(ids[id]);
      _;
     }
      constructor() public {
        owner = msg.sender;
        whitelist = new Whitelisted(owner);
        whitelist.addToWhitelist(owner);
    }

    //create a new ID and add it to ids array
    function _createID(uint _id) public whitelist.onlyWhitelisted{
        ID newId = new ID(_id, _whitelist);
        ids[_id]=newId;
        emit IDCreated(_id, newId);
    }
}
