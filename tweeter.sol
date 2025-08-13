// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract TweeterContract {
    struct Tweet {
        uint id;
        address author;
        string content;
        uint createdAt;
    }
    struct Message {
        uint id;
        string content;
        address from;
        address to;
        uint createdAt;
    }

    mapping(uint => Tweet) public tweets;
    mapping(address => uint[]) public tweetsOf;
    mapping(address => Message[]) public conversations;
    mapping(address => mapping(address => bool)) public operators;
    mapping(address => address[]) public following;

    uint nextId;
    uint nextMessageId;

    function _tweet(address _from, string memory _content) internal {
        tweets[nextId] = Tweet(nextId, _from, _content, block.timestamp);
        tweetsOf[_from].push(nextId);
        nextId = nextId + 1;
    }

    function _sendMessage(address _from, address _to, string memory _content) internal {
        conversations[_from].push(Message(nextMessageId, _content, _from, _to, block.timestamp));
        nextMessageId++;
    }

    function tweet(string memory _content) public {
        _tweet(msg.sender, _content);
    }

    function tweet(address _from, string memory _content) public {
        require(_from != address(0), "Invalid sender address");
        _tweet(_from, _content);
    }

    function sendMessage(address _to, string memory _content) public {
        require(_to != address(0), "Invalid recipient address");
        _sendMessage(msg.sender, _to, _content);
    }

    function sendMessage(address _from, address _to, string memory _content) public {
        require(_from != address(0), "Invalid sender address");
        require(_to != address(0), "Invalid recipient address");
        _sendMessage(_from, _to, _content);
    }

    function follow(address _followed) public {
        require(_followed != address(0), "Invalid followed address");
        following[msg.sender].push(_followed);
    }

    function allow(address _operator) public {
        require(_operator != address(0), "Invalid operator address");
        operators[msg.sender][_operator] = true;
    }

    function disallow(address _operator) public {
        require(_operator != address(0), "Invalid operator address");
        operators[msg.sender][_operator] = false;
    }

    function getLatestTweets(uint count) public view returns (Tweet[] memory) {
        require(count > 0 && count <= nextId, "Count is not proper");
        Tweet[] memory _tweets = new Tweet[](count);
        uint j;
        for (uint i = nextId - count; i < nextId; i++) {
            Tweet storage _structure = tweets[i];
            _tweets[j] = Tweet(_structure.id, _structure.author, _structure.content, _structure.createdAt);
            j++;
        }
        return _tweets;
    }

    function getLatestofUser(address _user, uint count) public view returns (Tweet[] memory) {
        require(_user != address(0), "Invalid user address");
        Tweet[] memory _tweets = new Tweet[](count);
        uint[] memory ids = tweetsOf[_user];
        require(count > 0 && count <= ids.length, "Count is not defined");
        uint j;
        for (uint i = ids.length - count; i < ids.length; i++) {
            Tweet storage _structure = tweets[ids[i]];
            _tweets[j] = Tweet(_structure.id, _structure.author, _structure.content, _structure.createdAt);
            j++;
        }
        return _tweets;
    }
}