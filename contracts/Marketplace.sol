pragma solidity ^0.4.24;

import "./AlienSpawner.sol";
import "./Upgrades.sol";

contract Marketplace is Upgrade {

  event ListItem(uint indexed startingBid, bool instabuyoption, bool leverage, uint indexed alienId, uint indexed AuctionId);
  event BidItem(address indexed bidder, uint indexed currentBid, uint indexed AuctionId);
  event AuctionEndLevTrue(address indexed NewOwner, uint indexed finalBid, uint leverage, uint indexed alienId);
  event AuctionEndNonLev(address indexed NewOwner, uint indexed finalBid, uint indexed AlienId);

  struct Auction {
   address oldOwner;
   uint value;
   uint auctionId;
   uint bidCount;
   uint8 time;
   bool instabuyoption;
   bool leverage;
   uint leverageSelector;
   bool ended;
  }

  Auction[] auction;

  mapping(address => address) public highestBidder;
  mapping(address => uint) public leverageInitiate;
  mapping(address => uint) public nonLeverageInitiate;
  mapping(uint => uint) public alienToAuction;


function randomAuctionId() private view returns (uint) {
  uint rand = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number))));
  return rand;
}


  function ListCard(uint _startingBid, bool _instabuyoption, bool _leverage, uint _alienId, uint _leverageSelector) external OnlyAlienOwner(_alienId) {
    require(alien[_alienId].level >= 1);
    require(_startingBid >= 0.001 ether); ///#DEV Min bid of 0.001 ether
    require(_instabuyoption == true);
    require(_leverageSelector <= 5);

    uint8 _time = uint8(now + 30 days);
    uint auctionId = randomAuctionId();

    if(_leverage == true) {
      leverageInitiate[msg.sender] = _alienId;
      alienToAuction[auctionId] = leverageInitiate[msg.sender];
      auction.push(Auction(msg.sender, _startingBid, auctionId, 0, _time, true, true, _leverageSelector, false));
    }

    else {
      nonLeverageInitiate[msg.sender] = _alienId;
      auction.push(Auction(msg.sender, _startingBid, auctionId, 0, _time,  true, false, 0, false));
    }

    alienToAuction[_alienId] = auctionId;
    emit ListItem(_startingBid, _instabuyoption, _leverage, _alienId, auctionId);
  }


  function PlaceBid(uint _auctionId, uint _alienId) external payable {
    require(msg.value > auction[_auctionId].value);
    require(msg.sender != auction[_auctionId].oldOwner);
    require(AlienOwner[_alienId].alienOwner != msg.sender);
    require(auction[_auctionId].ended == false);
    highestBidder[auction[_auctionId].oldOwner] = msg.sender;
    auction[_auctionId].value = msg.value;
    auction[_auctionId].bidCount++;
    emit BidItem(highestBidder[auction[_auctionId].oldOwner], auction[_auctionId].value, _auctionId);
  }

  function leverageChances(uint _auctionId) view public returns (uint) {
      uint leverageSelector = auction[_auctionId].leverageSelector;
      uint chances = 100;

      for(uint i = 1; i < leverageSelector;i++) {
        chances -=20;
      }

      return chances;
  }

  function leverageRandom() view public returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
    return rand;
  }



  function leverageResult(uint _auctionId) view public returns (bool) {
     uint chance = leverageChances(_auctionId);
     uint rand = leverageRandom();

     if(chance > rand) {
       return true;
     }

     else {
       return false;
     }

  }
  //function nonLeverageResult()

  function AuctionEnds(uint _auctionId) external payable {
    require(msg.value >= auction[_auctionId].value, "Ether sent must be equal to or of more value than the final bid amount. No additional Ether sent is returned.");
    require(highestBidder[auction[_auctionId].oldOwner] ==  msg.sender, "Only the final bidder can call this");
    require(now >= auction[_auctionId].time, "The auction must have ended");

    uint alienId = alienToAuction[_auctionId];
    uint transferEtherToBidder = auction[_auctionId].value * 1000000000000000000;
    address originalOwner = auction[_auctionId].oldOwner;
    address finalBidder = highestBidder[auction[_auctionId].oldOwner];
    uint leverage = auction[_auctionId].leverageSelector;

    originalOwner.transfer(transferEtherToBidder); //Transfer Ether = final bid value

    if(auction[_auctionId].leverage == true) {
       bool leverageRes = leverageResult(_auctionId);

       if(leverageRes == true) {
        _mint(alienId, finalBidder, leverage);
        transferFrom(originalOwner, finalBidder, alienId, 1);
        emit TransferWithQuantity(originalOwner, finalBidder, alienId, 1);
        emit AuctionEndLevTrue(finalBidder, auction[_auctionId].value, alienId, leverage);
        //emit transfer(auction[_auctionId].oldOwner, alien[_alienId]);
       }

       else if(leverageRes == false) {
        transferFrom(originalOwner, 0x0000000000000000000000000000000000000000, alienId, 1);
        emit TransferWithQuantity(originalOwner, 0x0000000000000000000000000000000000000000 , alienId, 1);
       }

       else {
         revert();
       }
    }

    else if(auction[_auctionId].leverage == false) {
      transferFrom(originalOwner, finalBidder, alienId , 1);
      emit TransferWithQuantity(originalOwner, finalBidder, alienId, 1);
      emit AuctionEndNonLev(finalBidder, auction[_auctionId].value, alienId);
    }

    else {
      revert();
    }

  }


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
