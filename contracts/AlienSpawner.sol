pragma solidity ^0.4.24;

import "../erc721x/contracts/Interfaces/ERC721X.sol";
import "../erc721x/contracts/Interfaces/ERC721XReceiver.sol";
import "../erc721x/contracts/Core/ERC721X/ERC721XTokenNFT.sol";
import "../erc721x/contracts/Libraries/ObjectsLib.sol";
import "../openzeppelin-solidity/contracts/AddressUtils.sol";

contract AlienCreation is ERC721XTokenNFT {


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

/*contract PlanetCreation is AlienCreation {

  event CreatePlanetEvents(uint planetId, uint ecosystemType);

  struct Planet {
    uint planetId;
    uint ecosystemType;
  }

  Planet[] planet;

mapping(uint => uint) public TokensToPlanet;
mapping(uint => address) public PlanetOwnerAddress;

  modifier PlanetCreateCheck(uint _planetId) {
    require(TotalCount[msg.sender] >= 1);
    require(PlanetOwnerAddress[_planetId] == 0);
    _;
  }

  modifier PlanetOwnerCheck(uint _planetId) {
    require(PlanetOwnerAddress[_planetId] == msg.sender);
    _;
  }

  function CreatePlanet(uint _planetId, uint _ecosystemType) internal PlanetCreateCheck(_planetId) {
    uint id = planet.push(Planet(_planetId, _ecosystemType));
    PlanetOwnerAddress[_planetId] = msg.sender;
    emit CreatePlanetEvents(id, _ecosystemType);
  }

 function AssignPlanet(address _sender, uint _planetId) internal PlanetOwnerCheck(_planetId) {
 require(_sender == msg.sender);

 //uint[] TokensOwned storage  = tokensOwned(_sender);

 for(uint i=0;i<AddressTokens.length;i++) {
   TokensToPlanet[AddressTokens[i]] = _planetId;
 }

 }

}*/
