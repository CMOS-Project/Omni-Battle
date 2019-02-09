pragma solidity ^0.4.24;

import "./AlienSpawner.sol";
import "./Upgrades.sol";

contract Marketplace is Upgrade {

  struct Auction {
   address oldOwner;
   uint minValue;
   uint tokenId;
   uint auctionId;
   bool instabuyoption;
   bool leverage;
  }

  Auction[] auction;

  mapping(address => address) public transactionParticipants;
  mapping(address => uint) public leverageInitiate;
  mapping(address => uint) public nonLeverageInitiate;
  mapping(uint => uint) public alienToAuction;



  function ListCard(uint _startingBid, bool _instabuyoption, bool _leverage, uint _tokenId, uint _auctionId, uint _alienId) public OnlyAlienOwner(_alienId) {
    require(alien[_alienId].level >= 1);
    require(_startingBid >= 0.001 ether); ///#DEV Min bid of 0.001 ether
    require(_instabuyoption == true);

    _tokenId = alien[_alienId].alienId;

    if(_leverage == true) {
      leverageInitiate[msg.sender] = _alienId;
      auction.push(Auction(msg.sender, _startingBid, _tokenId, _auctionId, true, true));
    }

    else {
      nonLeverageInitiate[msg.sender] = _alienId;
      auction.push(Auction(msg.sender, _startingBid, _tokenId, _auctionId, true, false));
    }

    alienToAuction[_alienId] = _auctionId;
  }


  function PlaceBid(/*uint _alienId,*/ uint _auctionId) public payable {
    require(msg.value >= auction[_auctionId].minValue);
    require(msg.sender != auction[_auctionId].oldOwner);
    transactionParticipants[auction[_auctionId].oldOwner] = msg.sender;
  }

  //function StartAuction
  /*function EndAuction() internal payable {

  }*/


  function SpecsLeverageBid(uint _alienId) external view returns (uint[3]) {  ///#DEV No way to return object in solidity yet
    require(leverageInitiate[msg.sender] == alien[_alienId].alienId);
    uint[3] memory check;
    check[0] = alien[_alienId].alienId;
    check[1] = alien[_alienId].attack;
    check[2] = alien[_alienId].defence;
    return check;
  }

  function SpecsNonLeverageBid(uint _alienId) external view returns (uint[3]) {  ///#DEV No way to return object in solidity yet
    require(nonLeverageInitiate[msg.sender] == alien[_alienId].alienId);
    uint[3] memory check;
    check[0] = alien[_alienId].alienId;
    check[1] = alien[_alienId].attack;
    check[2] = alien[_alienId].defence;
    return check;
  }

}
