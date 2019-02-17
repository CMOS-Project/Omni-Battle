pragma solidity ^0.4.24;

import "./AlienSpawner.sol";
import "./Marketplace.sol";
import "./PurchaseDirect.sol";
import "./Upgrades.sol";

contract AlienStatistics is Marketplace  {

///#DEV Planet Stats
function returnTotalPlanetCount() view external returns (uint) {
  uint total = planet.length;
  return total;
}

        function ecosystemTotals() view external returns (uint, uint, uint, uint) {
          uint barren = 0;
          uint cold = 0;
          uint desert = 0;
          uint water = 0;

          for(uint i=0; i < planet.length; i++) {
           if(keccak256(abi.encodePacked(planet[i].ecosystemType)) == keccak256(abi.encodePacked("Barren"))) {
           barren++;
           }

           else if(keccak256(abi.encodePacked(planet[i].ecosystemType)) == keccak256(abi.encodePacked("Cold"))) {
           cold++;
           }

           else if(keccak256(abi.encodePacked(planet[i].ecosystemType)) == keccak256(abi.encodePacked("Desert"))) {
           desert++;
           }

           else if(keccak256(abi.encodePacked(planet[i].ecosystemType)) == keccak256(abi.encodePacked("Water"))) {
           water++;
           }
           }

           return (barren,
             cold,
             desert,
             water);
        }

///#DEV Alien Stats
function TotalAlienCount() view external returns (uint) {
   uint total = alien.length;
   return total;
}

function TotalAuctionCount() view external returns (uint) {
  uint total = auction.length;
  return total;
}

function ActiveMarketplaceCount() view external returns (uint) {
  uint counter = 0;

  for(uint j = 0; j < auction.length;j++) {
    if(auction[j].ended == false) {
      counter++;
    }
  }

  for(uint i = 0; i < instabuy.length;i++) {
    if(instabuy[j].ended == false) {
      counter++;
    }
  }

  return counter;
}

function WeaponPercentage() view external returns (uint) {
  uint weaponCount = 0;
  uint alienCount = alien.length;

  for(uint i=0; i < alien.length; i++) {
    if(alien[i].weapon == true) {
      ratio++;
    }
  }

  uint ratio = weaponCount / alienCount;

  return ratio * 100;
}


}
