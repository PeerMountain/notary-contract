pragma solidity^0.4.21;

contract Ownable {
    address owner;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
}

contract Whitelisted is Ownable {
    mapping(address => bool) internal whitelistedAddresses;

    function isWhitelisted(address addr) internal view returns (bool) {
        return whitelistedAddresses[addr];
    }

    function whitelist(address addr) public onlyOwner {
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

contract Notary is Whitelisted {
    struct MessageData {
        string messageHash;
        string messageSender;
        uint64 timestamp;
    }
    MessageData[] messages;

    event MessageSaved(string messageHash);

    function Notary() public {
        owner = msg.sender;
    }

    function saveMessage(string messageHash, string messageSender, uint64 timestamp) public onlyWhitelisted {
        messages.push(
            MessageData(
                messageHash,
                messageSender,
                timestamp
            )
        );
        emit MessageSaved(messageHash);
    }
}

contract PublicNotary is Notary {
    // Inherits Notary's constructor
    function PublicNotary() Notary() public {}

    function saveMessage(string messageHash, string messageSender, uint64 timestamp) public onlyWhitelisted {
        messages.push(
            MessageData(messageHash, messageSender, timestamp)
        );
        emit MessageSaved(messageHash);
    }
}
