// SPDX-License-Identifier: UNDEFINED
// contract deployed at 0x13606aF056F3c178945d44Ed36a5eedD45cef8B1;
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/*
Create an ERC721 Token with the following requirements

user can only buy tokens when the sale is started
the sale should be ended within 30 days
the owner can set base URI
the owner can set the price of NFT
NFT minting hard limit is 100

Note:
you can use this link as a base URI = "
https://floydnft.com/token/&quot;
the contract should be deployed on any ethereum test network by using a hardhat or truffle

**/
contract MyNFT is ERC721("My NFT","MNFT"){
    address public owner;
    uint8 tokenId;
    uint256 startSale;
    uint256 saleTime;
    uint256 endSale;
    uint256 tokenPrice;
    string baseURI;
    
    constructor(){
        owner = _msgSender();
        tokenId = 0;
        saleTime = 2592000; // 30 days conversion into seconds
        tokenPrice = 0;
    }
    
    fallback() external payable {
        
    }

    receive() external payable {
        
    }
    
    modifier OnlyOwner(){
        require (_msgSender() == owner, "Only Owner can call this function.");
        _;
    }
    modifier maxSupply(){
        require (tokenId <= 100, "Maximum number of Token minted");
        _;
    }
    
    function setBaseURI(string memory _baseURI) external OnlyOwner() returns(bool){
        baseURI = _baseURI;
        return true;
    }
    
    function setTokenPrice(uint8 _ehterAmount) OnlyOwner() external{
        tokenPrice = (1 ether)*_ehterAmount;
    }
    function startTokenSale() OnlyOwner() external{
        startSale = block.timestamp;
        endSale = startSale + saleTime;
    }
    
    function buyNFT() maxSupply() payable external{
        require(_msgSender() != address(0) || _msgSender() != owner,"Owner or InValid address cannot buy NFTs.");
        require (startSale > 0,"Token Sale has not started.");
        require (block.timestamp <= endSale,"Token is not available for sale anymore.");
        require (msg.value >= tokenPrice,"Insufficient ether(s) to buy the token.");
        tokenId++;
        _safeMint(_msgSender(),tokenId);
        payable(address(this)).transfer(msg.value);
    }
    
    function contractEtherBalance() view external OnlyOwner() returns(uint256){
        return address(this).balance;
    }
    function destroyToken() external payable OnlyOwner(){
        selfdestruct(payable(owner));
    }
}