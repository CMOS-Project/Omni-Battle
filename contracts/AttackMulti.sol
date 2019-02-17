pragma solidity ^0.4.24;

import "./AlienSpawner.sol";
import "./AlienStatistics.sol";
import "./Marketplace.sol";
import "./Upgrades.sol";
import "./PurchaseDirect.sol";

contract Attack is DailyDrop {

event AttackTranspired();
event CooldownBegins();


modifier CheckCooldown(uint _alienId, uint _planetId) {
  require(now >= alien[_alienId].cooldown);
  _;
}

/*struct Attack {
  
}

mapping(Attack => uint) public TokensInvolved;
mapping(address => address) public PlayersInvolved;

function InitiateAttack(uint _alienId,
uint _planetId,
uint _defenderAlienId,
uint _defenderPlanetId) external {


}*/



}
