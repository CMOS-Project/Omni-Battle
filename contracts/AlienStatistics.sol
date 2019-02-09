pragma solidity ^0.4.24;

import "./AlienSpawner.sol";

contract AlienStatistics is AlienCreation {

///#DEV Planet Stats
function returnTotalPlanetCount() view external returns (uint) {
  uint total = planet.length;
  return total;
}

function WaterCount() view external returns (uint) {
  uint water = 0;

   for(uint i=0; i < planet.length; i++) {
    if(keccak256(abi.encodePacked(planet[i].ecosystemType)) == keccak256(abi.encodePacked("Water"))) {
      water++;
    }
    }
   return water;
  }


  function BarrenCount() view external returns (uint) {
    uint barren = 0;

     for(uint i=0; i < planet.length; i++) {
      if(keccak256(abi.encodePacked(planet[i].ecosystemType)) == keccak256(abi.encodePacked("Barren"))) {
        barren++;
      }
      }
     return barren;
    }

    function DesertCount() view external returns (uint) {
      uint desert = 0;

       for(uint i=0; i < planet.length; i++) {
        if(keccak256(abi.encodePacked(planet[i].ecosystemType)) == keccak256(abi.encodePacked("Desert"))) {
          desert++;
        }
        }
       return desert;
      }

      function ColdCount() view external returns (uint) {
        uint cold = 0;

         for(uint i=0; i < planet.length; i++) {
          if(keccak256(abi.encodePacked(planet[i].ecosystemType)) == keccak256(abi.encodePacked("Cold"))) {
          cold++;
          }
          }
         return cold;
        }

///#DEV Alien Stats
function returnTotalAlienCount() view external returns (uint) {
   uint total = alien.length;
   return total;
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
