pragma solidity ^0.4.24;

import "./AlienSpawner.sol";

contract Upgrade is AlienCreation {


function UpgradeCheck(uint _planetId) public view returns (uint) {
  return planet[_planetId].tokenCount;
}

function UpgradeCapacity(uint _planetId) public payable planetOwnerCheck(_planetId)  {
  require(msg.value == 0.001 ether, "0.001 ETH must be transferred");
  uint tokenCount = UpgradeCheck(_planetId);
  if(tokenCount == 100) {
   planet[_planetId].capacity = 250;
   planet[_planetId].level++;
}

else if(tokenCount == 250) {
  planet[_planetId].capacity = 500;
  planet[_planetId].level++;
}

else if(tokenCount == 500) {
  planet[_planetId].capacity = 1000;
  planet[_planetId].level++;
}

else if(tokenCount == 1000) {
  planet[_planetId].capacity = 2500;
  planet[_planetId].level++;
}

else if(tokenCount == 2500) {
  planet[_planetId].capacity = 5000;
  planet[_planetId].level++;
}

else {
  revert("Full capacity has not been reached");
}

}

function UpgradeWeaponry(uint _alienId, uint _weaponId) public payable OnlyAlienOwner(_alienId) CheckWeaponMerge(_weaponId, _alienId) {
require(msg.value == 0.0001 ether, "0.0001 ETH must be transferred");
weapon[_weaponId].attack++;
alien[_alienId].attack++;
}

}
