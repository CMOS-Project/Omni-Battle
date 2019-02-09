pragma solidity ^0.4.24;

import "../erc721x/contracts/Interfaces/ERC721X.sol";
//import "../erc721x/contracts/Core/ERC721X/ERC721XToken.sol";
import "../erc721x/contracts/Interfaces/ERC721XReceiver.sol";
import "../erc721x/contracts/Core/ERC721X/ERC721XTokenNFT.sol";


contract PlanetCreation is ERC721XTokenNFT {

  uint PlanetTypes = 12;
  uint PlanetCombos = 25 ** PlanetTypes;

  event CreatePlanetEvents(uint planetId, string name, bytes32 ecosystemType); ///#DEV Create alien event

  struct Planet {  ///#DEV Planet properties
    string name;
    bytes32 ecosystemType;
    uint planetId;
    uint tokenCount;
    uint capacity;
    uint level;
    address owner;
  }

  Planet[] planet; ///#DEV Planet lookup array

mapping(uint => Planet) public AssignPlanet; ///#DEV Assign planet to person called contract
mapping(address => uint) public PlanetCount; ///#DEV Planet count to address
mapping(uint => uint) public TokensToPlanet; ///#DEV Overall token count to planet

  modifier PlanetCreateCheck() {  //#DEV Check 0 planets created
    require(PlanetCount[msg.sender] == 0);
    _;
  }

  modifier PlanetExistCheck() {
    require(PlanetCount[msg.sender] >= 1);
    _;
  }

  function prepareEco(string _random) public pure returns (bytes32) {
    uint number = uint(keccak256(abi.encodePacked(_random)));  ///#DEV Return random number between 0 and 100
    bytes32 water = "Water";
    bytes32 barren = "Barren";
    bytes32 desert = "Desert";
    bytes32 cold = "Cold";

    if(number >= 0 && number < 10) {
     return water;
    }

    else if(number >= 10 && number < 50) {
      return barren;
    }

    else if(number >= 50 && number < 75) {
     return desert;
    }

    else if(number >= 75 && number <= 100) {
     return cold;
    }
  }

  function preparePlanetId(string _random) public view returns (uint) {
    uint randnumber = uint(keccak256(abi.encodePacked(_random)));
    return randnumber % PlanetCombos;
  }

  function preparePlanet(string _name, bytes32 _ecosystemType, uint _planetId) public PlanetCreateCheck() {
    uint id = planet.push(Planet(_name, _ecosystemType, _planetId, 0, 100, 1, msg.sender)) - 1;
    AssignPlanet[id] = Planet(_name, _ecosystemType, _planetId, 0, 100, 1, msg.sender);

    TokensToPlanet[id] = planet[id].tokenCount;
    emit CreatePlanetEvents(id, _name, _ecosystemType);
  }

  function CreatePlanet(string _name) public PlanetCreateCheck() {
    bytes32 eco = prepareEco(_name);
    uint planetNum = preparePlanetId(_name);
    preparePlanet(_name, eco, planetNum);
  }

  /*function UserCreatePlanet(
  string _name,
  uint _tokenCount,
  uint _capacity,
  uint _level,
  address _owner
  )
  public PlanetCreateCheck {
    PlanetCreateCheck(_name, _ecosystemType, tokenCount, _capacity, _level, _owner);

  }*/

  modifier planetOwnerCheck(uint _planetId) { ///#DEV Check that planet belongs to person calling contract
    require(AssignPlanet[_planetId].owner == msg.sender);
    _;
  }

  /*modifier planetCountCheck(uint _planetId) {
    require();
  }*/

/*function PlanetToUser(
  bytes32 _name,
  ) {

}*/
}

contract WeaponCreation is PlanetCreation {

  event WeaponCreate(uint weaponId);

  uint32 weaponCombos = 2**16;

  struct Weapon {
    uint id;
    uint attack;
  }

  Weapon[] weapon;

  function randomiseId() view private returns (uint) {
    uint randomNumber = uint(keccak256(abi.encodePacked(msg.sender, block.number)));
    return randomNumber % weaponCombos;
  }

  function weaponMerge() public returns (uint) {
    uint random = randomiseId();
    uint id = weapon.push(Weapon(random, 1)) - 1;
    emit WeaponCreate(id);
    return weapon[random].id;
  }

}


contract AlienCreation is WeaponCreation {


  uint AlienDna = 10;
  uint AlienTypes = 25;
  uint AlienCombos = AlienDna ** AlienTypes; ///#DEV Total possible combos for regular card = 10^25


     function CardGetterName(string CardName) public pure returns(string) {
       CardName = "Regular Alien";  ///#DEV Name of card for Loom network marketplace and plasma
       return CardName;
     }

     function CardGetterSymbol(string CardSymbol) public pure returns(string) {
       CardSymbol = "ALIEN";     ///#DEV Symbol of card for Loom network marketplace and plasma
       return CardSymbol;
     }

    event AlienStarter(uint alienId, string name);  ///#DEV Event for JavaScript

    struct Alien { //#DEV Variable properties for Alien card type
        address alienOwner;
        string name;
        bool weapon;
        uint alienId;
        uint level;
        uint attack;
        uint defence;
        uint wincount;
        uint losscount;
        uint8 cooldown;
    }

    Alien[] public alien;

    //mapping(uint => address) AlienAddress;  ///#DEV Mapping for Alien token ID to owner
    mapping(uint => Alien) AlienOwner;
    mapping(address => uint) TotalCount;   ///#DEV Total alien card count to address
    mapping(uint => uint) WeaponMerge; ///#DEV Map weapon add on to alienId

     modifier StarterAirdrop() {
       require(TotalCount[msg.sender] == 0);  /// #DEV Check that alien type card count is 0
       _;
    }

    modifier OnlyAlienOwner(uint _alienId) {
        require(AlienOwner[_alienId].alienOwner == msg.sender);  ///#DEV Require to check that person calling function is owner of the card
        _;
    }

    modifier CheckWeaponMerge(uint _weaponId, uint _alienId) {
        require(WeaponMerge[_weaponId] == _alienId);
        _;
    }

    ///#DEV Initial airdrop of game token on starting the game
    function AirdropAlien(string memory _name, uint _alienId) public {
        require(PlanetCount[msg.sender] >= 1, "This address must have at least 1 planet assigned to it"); ///#DEV Check 1 planet assigned
        uint id = alien.push(Alien(msg.sender, _name, false, _alienId, 1, 0, 0, 0, 0, uint8(now + 1 days))) - 1;
        AlienOwner[id] = Alien(msg.sender, _name, false, _alienId, 1, 0, 0, 0, 0, uint8(now + 1 days)); ///#DEV Assigns id to person calling function - makes them owner
        TotalCount[msg.sender]++; ///#DEV Alien count +1
        emit AlienStarter(id, _name); ///Trigger event
    }

    function GenerateRandomAlien(string memory _namestr) private view returns (uint) {
        uint RandomName = uint(keccak256(abi.encodePacked(_namestr))); ///Pseudo random 256bit string generated from keccak hash function
        return RandomName % AlienCombos; ///#DEV Return any remainder (random number) from 10^25 (AlienCombos) to be alion id
    }

    function CreateStarterAlien(string _name) public StarterAirdrop {
       uint randomId = GenerateRandomAlien(_name);
       //uint AlienType = GenerateRandomAlien(_name); ///#DEV Call above function with name parameter to produce random no.
       AirdropAlien(_name, randomId);
    }

    function AddWeaponry(uint _alienId) public OnlyAlienOwner(_alienId) {
        require(AlienOwner[_alienId].weapon == false);
        uint weaponCreation = weaponMerge();
        _mint(weaponCreation, msg.sender);
        WeaponMerge[weaponCreation] = _alienId;
        AlienOwner[_alienId].attack++; ///#DEV Add +1 attack point to token that person chooses to call function with
        AlienOwner[_alienId].weapon = true;
    }

    function BuyAlien(uint _alienId) public payable PlanetExistCheck {
      require(msg.value >= 0.001 ether);
      uint amount = msg.value / 0.001 ether;
      for(uint i = 0; i < amount; i++) {
      _mint(_alienId, msg.sender);
    }
    }

    ///#DEV 50/50 chance of receiving weapon add on
    function RandGen(string memory _randomweaponstr) private pure returns (uint) {
        uint RandomNum = uint(keccak256(abi.encodePacked(_randomweaponstr))) % 100; ///#DEV Random no. (1-100) probability of getting weapon bonus on initial airdrop
        return RandomNum;
    }

    //function WeaponProb(uint _tokenId) private TokenOwner(_tokenId) {
        //require(RandGen()); ///#DEV Must run RandGen
        //AddWeaponry(_tokenId);
    //}
}
