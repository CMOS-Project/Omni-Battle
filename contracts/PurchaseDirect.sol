pragma solidity ^0.4.24;

import "./Marketplace.sol";
import "./Nebuli.sol";
import "./AlienSpawner.sol";


/*contract VirtualCoins is Marketplace {


}*/

contract Purchase is Marketplace { //NebuliToken

   //NebuliToken ERC20;


///#DEV Regular
function cloneAlien(uint _alienId) external payable PlanetExistCheck  {
    require(msg.value >= 0.001 ether);
    require(alien[_alienId].level >= 1);

    uint amount = msg.value / 0.001 ether;
    _mint(_alienId, msg.sender, amount);
    /*for(uint i = 0; i < amount; i++) {
    _mint(_alienId, msg.sender);*/
  }

function buyAdditionalPlanet(string _name) external payable PlanetExistCheck {
require(msg.value >= 0.1 ether);
createPlanet(_name);
}

}

contract DailyDrop is Purchase {

event DropIdCreation(uint indexed planetId);
event DropRedeemed(address indexed claimant, string indexed rewardType, uint indexed timeOfClaim);

  struct DropClaim {
    uint8 claimTime; //Use blockstamp
    uint8 previousClaim;
    uint dropClaimId;
    uint accumulatorScore;
    //bool[7] recentClaims;
  }

DropClaim[] dropclaim;

//mapping(uint => uint) DailyDropClaim; ///#DEV Map drop claim to planet Id

modifier CheckAirdropRequirements(uint _planetId, uint _dropClaimId) {
require(_planetId == _dropClaimId);
_;
}

function createDropClaimId(uint _planetId) external {
dropclaim.push(DropClaim(uint8(now + 1 days), 0, _planetId, 0));
emit DropIdCreation(_planetId);
}

function randomDrop() public view returns (uint) { ///#DEV Return number up to 4. 0 = virtual coins (copper), 1 = bronze, 2 = silver, 3 = gold, 4 = tokens
uint randNumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
return randNumber % 4;
}

function officialDropClaim(uint _planetId, uint _dropClaimId, uint _alienId)
   external
   PlanetExistCheck
   CheckAirdropRequirements(_planetId, _dropClaimId) {

  uint random = randomDrop();
  uint acca = dropclaim[_dropClaimId].accumulatorScore;
  uint coins = 0;
  uint claimRequire = dropclaim[_dropClaimId].claimTime + 1 days;

  require(now >= claimRequire, "Must be at least 24 hours gap between claiming drops");


  if(dropclaim[_dropClaimId].accumulatorScore == 7) { //Reset claim chain
     dropclaim[_dropClaimId].accumulatorScore = 0;
  }


  if(random == 0) {
    for(uint x = 1; x < acca;x++) {
      coins+=100;
    }

  _mint(0, msg.sender, coins);
  emit DropRedeemed(msg.sender, "Copper", block.timestamp);
  }

  else if(random == 1) {
    for(uint i = 1; i < acca;i++) {
      coins+=80;
    }
  _mint(1, msg.sender, coins);
  emit DropRedeemed(msg.sender, "Bronze", block.timestamp);
  }

  else if(random == 2) {
    for(uint j = 1; j < acca;i++) {
     coins+=40;
    }
  _mint(2, msg.sender, coins);
  emit DropRedeemed(msg.sender, "Silver", block.timestamp);
  }

  else if(random == 3) {
  for(uint k = 1; k < acca;i++) {
     coins+=20;
  }
  _mint(3, msg.sender, coins);
  emit DropRedeemed(msg.sender, "Gold", block.timestamp);
  }

  else if(random == 4) {
  _mint(_alienId, msg.sender, acca);
  emit DropRedeemed(msg.sender, "Token", block.timestamp);
  }

  dropclaim[_dropClaimId].accumulatorScore++;
  dropclaim[_dropClaimId].claimTime = uint8(block.timestamp);

  //dropclaim[_dropClaimId].recentClaims.shift();
  //dropclaim[_dropClaimId].recentClaims[6] = true;
}

}
