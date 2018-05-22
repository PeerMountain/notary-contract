pragma solidity ^0.4.24;

import'./Whitelisted.sol'

contract ID{

	uint id;
	Whitelisted whitelist;
	mapping (string => MessageData) public messages;

	event MessageSaved(string messageHash);

	constructor(uint _id, address _whitelist) public {
		owner = msg.sender;
		id = _id;
		whitelist = Whitelisted(_whitelist);
	}

	struct MessageData {
		string messageSender;
		uint64 timestamp;
	}

	function saveMessage(string messageHash, string messageSender, uint64 timestamp) public whitelist.onlyWhitelisted {
		messages[messageHash]=MessageData(messageSender,timestamp);
		emit MessageSaved(messageHash);
	}

}