require("@nomiclabs/hardhat-waffle");
require(`dotenv`).config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
const Private_Key = process.env.PRIVATE_KEY; //this contains the private key of you metamask account
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0", // here comes your solidity compiler version
  networks:{
    ropsten:{
      url: process.env.INFURA_API_KEY, // here comes your infura API Key to connect your contract with the network
      accounts: [`0x${Private_Key}`] // Private key and Infura API key are secretly stored in .env file
    }
  }
};