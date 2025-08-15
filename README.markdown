# Tweeter Smart Contract

## Overview
The Tweeter Smart Contract is a decentralized application (dApp) built on the Ethereum blockchain, mimicking core functionalities of a social media platform like Twitter. It allows users to post tweets, send private messages, follow other users, and manage operator permissions. The contract is written in Solidity and is compatible with Solidity versions >=0.5.0 and <0.9.0.

## Features
- **Tweet**: Users can post tweets, which are stored on-chain with an ID, author address, content, and timestamp.
- **Send Messages**: Users can send private messages to other users, stored in a conversation mapping.
- **Follow**: Users can follow other addresses, maintaining a list of followed accounts.
- **Operator Permissions**: Users can allow or disallow operators to perform actions on their behalf.
- **Retrieve Tweets**: Functions to fetch the latest tweets globally or for a specific user.

## Contract Structure
### Data Structures
- **Tweet**: Stores tweet details (`id`, `author`, `content`, `createdAt`).
- **Message**: Stores message details (`id`, `content`, `from`, `to`, `createdAt`).
- **Mappings**:
  - `tweets`: Maps tweet IDs to `Tweet` structs.
  - `tweetsOf`: Maps user addresses to arrays of their tweet IDs.
  - `conversations`: Maps user addresses to arrays of their messages.
  - `operators`: Maps user addresses to operator permissions.
  - `following`: Maps user addresses to arrays of addresses they follow.

### Key Functions
- **tweet(string memory _content)**: Allows a user to post a tweet.
- **tweet(address _from, string memory _content)**: Allows an operator to post a tweet on behalf of a user.
- **sendMessage(address _to, string memory _content)**: Sends a private message to another user.
- **sendMessage(address _from, address _to, string memory _content)**: Allows an operator to send a message on behalf of a user.
- **follow(address _followed)**: Adds an address to the user's following list.
- **allow(address _operator)**: Grants an address permission to act as an operator.
- **disallow(address _operator)**: Revokes operator permission.
- **getLatestTweets(uint count)**: Retrieves the latest tweets globally (up to `count`).
- **getLatestofUser(address _user, uint count)**: Retrieves the latest tweets of a specific user (up to `count`).

## Prerequisites
- **Solidity Compiler**: Version >=0.5.0 and <0.9.0.
- **Ethereum Development Environment**: Tools like Remix, Hardhat, or Truffle.
- **MetaMask or Wallet**: To interact with the contract on an Ethereum network.
- **Test Network**: Deploy on testnets like Ropsten or Rinkeby for testing.

## Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/tweeter-smart-contract.git
   cd tweeter-smart-contract
   ```
2. **Install Dependencies** (if using Hardhat/Truffle):
   ```bash
   npm install
   ```
3. **Compile the Contract**:
   - Using Remix: Copy the contract code into the Remix IDE, select the appropriate compiler version, and compile.
   - Using Hardhat:
     ```bash
     npx hardhat compile
     ```
4. **Deploy the Contract**:
   - Using Remix: Deploy directly via the Remix interface.
   - Using Hardhat: Configure the network in `hardhat.config.js` and run:
     ```bash
     npx hardhat run scripts/deploy.js --network <network-name>
     ```

## Usage
1. **Deploy the Contract**: Deploy to your preferred Ethereum network.
2. **Interact with the Contract**:
   - **Post a Tweet**: Call the `tweet` function with the tweet content.
   - **Send a Message**: Use the `sendMessage` function with the recipient's address and message content.
   - **Follow Users**: Call the `follow` function with the address to follow.
   - **Manage Operators**: Use `allow` or `disallow` to manage operator permissions.
   - **Fetch Tweets**: Use `getLatestTweets` or `getLatestofUser` to retrieve tweets.
3. **Test the Contract**:
   - Write test cases using Mocha/Chai in Hardhat or use Remix's testing interface.
   - Example test scenarios:
     - Verify tweet creation and retrieval.
     - Check message sending and conversation history.
     - Test operator permissions and follow functionality.

## Example
```javascript
// Example using ethers.js
const contract = new ethers.Contract(contractAddress, abi, signer);

// Post a tweet
await contract.tweet("Hello, Ethereum!");

// Send a message
await contract.sendMessage("0xRecipientAddress", "Hey, what's up?");

// Follow a user
await contract.follow("0xUserAddress");

// Get latest 5 tweets
const latestTweets = await contract.getLatestTweets(5);
console.log(latestTweets);
```

## Security Considerations
- **Input Validation**: The contract includes checks for valid addresses (non-zero addresses).
- **Gas Optimization**: Be mindful of gas costs when retrieving large numbers of tweets or messages.
- **Access Control**: Only authorized operators can perform actions on behalf of users.
- **Upgradeability**: This contract is not upgradeable; consider using a proxy pattern for future upgrades.

## Contributing
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit (`git commit -m "Add feature"`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a pull request.

## Contact
For questions or suggestions, open an issue on GitHub or contact the repository owner.
