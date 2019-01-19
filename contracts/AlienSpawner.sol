pragma solidity ^0.4.24;

import "../erc721x/contracts/Interfaces/ERC721X.sol";
import "../erc721x/contracts/Interfaces/ERC721XReceiver.sol";
import "../erc721x/contracts/Core/ERC721X/ERC721XTokenNFT.sol";
import "../erc721x/contracts/Libraries/ObjectsLib.sol";
import "../openzeppelin-solidity/contracts/AddressUtils.sol";


contract PlanetCreation is ERC721XTokenNFT {

  uint PlanetTypes = 12;
  uint PlanetCombos = 25 ** PlanetTypes;

  event CreatePlanetEvents(uint planetId, uint tokenCount, uint capacity, uint level); ///#DEV Create alien event

  struct Planet {  ///#DEV Planet properties
    string name;
    bytes32 ecosystemType;
    uint tokenCount;
    uint capacity;
    uint level;
    address owner;
  }

  Planet[] planet; ///#DEV Planet lookup array

mapping(uint => Planet) public AssignPlanet; ///#DEV Assign planet to person called contract
mapping(address => uint) public PlanetAlienCount; ///#DEV Alien count to planet
mapping(uint => uint) public TokensToPlanet; ///#DEV Overall token count to planet

  modifier PlanetCreateCheck() {  //#DEV Check 0 planets created
    //require(TotalCount[msg.sender] >= 1);
    require(PlanetAlienCount[msg.sender] == 0);
    _;
  }

  function CreatePlanet(string _name,
    bytes32 _ecosystemType, ///#DEV Create planet
    uint _tokenCount,
    uint _capacity,
    uint _level,
    address _owner)

    private PlanetCreateCheck() {
    uint id = planet.push(Planet(_name, _ecosystemType, 0, 100, 1, _owner)) - 1;
    planet[id].owner = msg.sender;
    AssignPlanet[id] = Planet(_name, _ecosystemType, 0, 100, 1, msg.sender);
    TokensToPlanet[id] = planet[id].tokenCount;
    emit CreatePlanetEvents(id, _tokenCount, _capacity, _level);
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

/*function PlanetToUser(
  bytes32 _name,
  ) {

}*/


  function prepareEco(string _random) public pure returns (uint) {
    uint randnumber = uint(keccak256(abi.encodePacked(_random)));  ///#DEV Return random number between 0 and 100
    return randnumber % 100;
  }

  function chooseEcosystem(uint _planetId, string _random) private planetOwnerCheck(_planetId) {  ///#DEV Randomise planet ecosystem
   uint number = prepareEco(_random);
   if(number >= 0 && number < 10) {
      planet[_planetId].ecosystemType = "Water";
   }

   else if(number >= 10 && number < 50) {
     planet[_planetId].ecosystemType = "Barren";
   }

   else if(number >= 50 && number < 75) {
    planet[_planetId].ecosystemType = "Desert";
   }

   else if(number >= 75 && number <= 100) {
    planet[_planetId].ecosystemType = "Cold";
   }

   else {
     revert("The number received was not within the required range.");  ///#DEV Abandon state change
   }
}
}


contract AlienCreation is PlanetCreation {


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

    event AlienStarter(address alienOwner, uint alienId, string name, uint attack, uint defence);  ///#DEV Event for frontend JavaScript

    struct Alien { //#DEV Variable properties for Alien card type
        address alienOwner;
        string name;
        uint attack;
        uint defence;
    }

    Alien[] public alien;

    //mapping(uint => address) AlienAddress;  ///#DEV Mapping for Alien token ID to owner
    mapping(uint => Alien) AlienOwner;
    mapping(address => uint) TotalCount;   ///#DEV Total alien card count to addresss

     modifier StarterAirdrop() {
       require(TotalCount[msg.sender] == 0);  /// #DEV Check that alien type card count is 0
       _;
    }

    modifier OnlyAlienOwner(uint _alienId) {
        require(AlienOwner[_alienId].alienOwner == msg.sender);  ///#DEV Require to check that person calling function is owner of the card
        _;
    }

    ///#DEV Initial airdrop of game token on starting the game
    function AirdropStartingAlien(address _alienOwner, string memory _name, uint _attack, uint _defence) private {
        uint id = alien.push(Alien(_alienOwner, _name, 0, 0)) - 1;
        alien[id].alienOwner = msg.sender;
        AlienOwner[id] = Alien(_alienOwner, _name, 0, 0); ///#DEV Assigns id to person calling function - makes them owner
        TotalCount[msg.sender]++; ///#DEV Alien count +1
        emit AlienStarter(_alienOwner, id, _name, _attack, _defence); ///Trigger event
    }

    function GenerateRandomAlien(string memory _namestr) private view returns (uint) {
        uint RandomName = uint(keccak256(abi.encodePacked(_namestr))); ///Pseudo random 256bit string generated from keccak hash function
        return RandomName % AlienCombos; ///#DEV Return any remainder (random number) from 10^25 (AlienCombos). RandomName possible combos = 2^256
    }

    function CreateAlien(address _alienOwner, string memory _name, uint _attack, uint _defence) public StarterAirdrop {
       //uint AlienType = GenerateRandomAlien(_name); ///#DEV Call above function with name parameter to produce random no.
       AirdropStartingAlien(_alienOwner, _name, _attack, _defence);
    }

    function AddWeaponry(uint _alienId) public OnlyAlienOwner(_alienId) {
        alien[_alienId].attack++; ///#DEV Add +1 attack point to token that person chooses to call function with
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
