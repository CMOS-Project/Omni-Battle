pragma solidity ^0.4.16;

import "./AlienOwnership.sol";
import "./safemath.sol";
import "./ERC721.sol";
import "./interest.sol";

/// #CONTRACT Create Core Base
contract CreateCoreBase is interest, safemath {

    event GenerateCore(uint hp, uint value, uint CoreId);

    struct CoreBase{
    uint hp;
    uint RegenRate;
    uint interest;
    uint value;
    string Aliens;
    uint AlienCount;
    uint LossCounter;
    uint WinCounter;
}

CoreBase[] Core;

mapping (address => uint) CoreBaseOwner; ///#DEV Find which CoreBase Id belongs to corresponding ETH address

function GenerateCoreBase(_hp, _RegenRate, _interest, _value, _AlienCount, _LossCounter, _WinCounter) private {
    address owner = msg.sender;
    require(balanceOf(msg.sender) < 1 );
    CoreBase.AlienCount = balanceOf(msg.sender);
    uint CoreId = CoreBase.push(Core(100, 1 days, 0, 0, Aliens[],  _AlienCount, 0, 0) - 1);
    CoreBaseOwner(_CoreId);
    GenerateCore(_hp, _value, _Core);
}

}

/// #CONTRACT Create the Aliens contract
contract AlienSpawner is SafeMath, ERC721, CreateCoreBase {

    event CreateAlien(uint Alienstrand, uint name, uint AlienId);


    uint Combos = 20;
    uint Total = 20 ** Combos; /// #DEV Total combos of Alien type 1
    uint HybridCooldown = 1 days;


    struct AlienType {
        string name;
        string AlienSub;
        uint attack;
        uint defence;
        uint level;
        uint armor;
        uint64 AttackCooldown;
        uint64 AmalgamationCooldown;
    }

AlienType[] alien; ///#DEV Aliens array

mapping(address => uint) AlienOwner; //#DEV Find Aliens owned by ETH address (Key = ETH Address & Value = id of Alien)

address owner = msg.sender;

function CreateRandomAlien(_name, _AlienSub, _attack, _defence, _level, _armor, _AttackCooldown, _AmalgamationCooldown) private {
    uint AlienId = alien.push(AlienType(_name, _AlienSub, _attack, _defence, 5, 5, uint64(_AttackCooldown + _AmalgamationCooldown)) - 1); ///#DEV Add alien (Name, attack score, defence score, level, armor boost, cooldown between attacks, hybrid creation, start at index 0)
    AlienOwner[_AlienId];
    CreateAlien(_strand, _name, _tokenId);
}

string _str;


///#DEV Better to create separate card type with ERC721X out. Keeping for now.
function GetAlienRand(_owner, _AlienId) internal returns(uint) {
    require(balanceOf(_owner, _AlienId) < 3);
    return  _str == keccak256(_str);
     /// #DEV First time users can generate 3 aliens to start off with
     /// #DEV Generates a random 256 bit string
}

      ///uint(msg.sender) == uint(keccak256(_str));


    function TypeOfAlien(uint _defence, uint _attack, string _AlienType) private {
        CreateRandomAlien(_strand, _Aliensub, _name, _attack, _defence, _AttackCooldown);
        GetAlienRand();

        uint counter_x = 0;
        uint counter_y = 0;

    for(uint i = 0; i < _str.length; i++) {  /// #DEV Loop through all letters

        if(_str[i] = "x") {
        counter_x = counter_x + add(1);
        }
        else if(_str[i] = "y") {
            counter_y = counter_y + add(1);
        }

    if(counter_x > 7 && counter_y <= 8  ) { /// #DEV If more than 15 Xs
      AlienType.defence = _AlienType.defence + add(5);  /// #DEV Safe math. Adds +5 defence
      AlienType.AlienSub = keccak256("Anorak");  /// #DEV Higher than average defence
    }

    else if(counter_y > 7 && counter_x <= 8) {
      AlienType.attack = AlienType._attack + add(5);        /// #DEV Safe math. Adds +5 attack
      AlienType.AlienSub = keccak256("Varg");        /// #DEV If more than 15 Ys
                                       /// #DEV Higher than average attack
    }

    else if(counter_x > 7 && counter_y > 7) {
     AlienType.defence = AlienType._defence + add(5);
     AlienType.attack = AlienType._attack + add(5);   /// #DEV
     AlienType.AlienSub = keccak256("Zorg");/// #DEV If more than 15Xs and 15Ys
                                 /// #DEV All rounded
    }

    else {
        AlienType.AlienSub = keccak256("Regular"); /// #DEV Common Starter
    }
}
}
/// Assign newly created alien to the base

   function AssignAlienCoreBase(_AlienId) internal {
    require(msg.sender == OwnerOf(_AlienId)); /// #DEV Must be the owner of alien
    require(msg.sender == OwnerOf(_CoreId)); ///#DEV Must own the core base
    CoreBase.Aliens.push(_AlienId); /// #DEV Add Zombie to the core base
    CoreBase._AlienNum = CoreBase._AlienNum + add(1); /// #DEV Alien count increases by 1
}

}

contract ArmorSpawner is AlienSpawner, CreateCoreBase {

    event CreateArmors(uint armorId, uint Type, uint defence);
    event ArmorUsed(uint armorId, uint used);

    struct Armor{
    string ArmorType;
    uint defence;
    uint used;
    }

    mapping(address => uint) ArmorOwner;

     Armor[] armors;


    function CheckAlienIdBase(_CoreId, _AlienId) internal view returns (bool) {
        if(OwnerOf(_CoreId) = OwnerOf(_AlienId)) {
           return true;
        }

        else {
          return false;
        }
    }

    function CheckArmorPresent() internal view returns (bool) {
        if(AlienType.armor > 0) {
          return true;
        }

        else {
          return false;
        }
    }

    function CreateArmor() internal {
        address owner = msg.sender;
        require(CheckArmorPresent = false);
        uint armorId = armors.push("Regular", 10 );
        ArmorOwner[_ArmorId];
        CreateArmor(_Type, _defence);
        ArmorUsed(_armorId, _used );
    }

    function CheckArmorUsed() internal view returns (bool) {
        if(Armor.used = true) {
            return true;
        }
        else {
            return false;
        }
    }

    function AssignArmor(_Alien_id) internal {
        require(CheckAlienIdBase() = true);
        require(msg.sender == OwnerOf(_AlienId));
        require(AlienType.level > 1);
        require(CheckArmorUsed() = false);
        CreateArmor();
        AlienType.defence = AlienType.defence + add(10);
        delete armorId;
    }

}

contract weapons is AlienSpawner, CreateCoreBase {

    event WeaponCreation(uint weaponId, uint attack);

    uint Combos = 16;
    uint Total = 16 ** Combos;

    struct weapons {
        uint attack;
        uint occupied;
        uint cooldown;
    }

    weapons[] Weapons;

    function CreateWeapons() internal {
       require(CheckAlienIdBase = true);
       uint weaponId = weapons.push(Weapons(_attack, _occupied));
       WeaponCreation(_weaponId, _attack);
    }

    function CheckWeaponsPresent() internal view returns (bool) {
        if(weapons.occupied = true) {
            return true;
        }

        else {
            return false;
        }
    }

    function AssignWeapons(_AlienId) internal {
        require(CheckAlienIdBase() = true);
        require(msg.sender == OwnerOf(_tokenId));
        require(msg.sender == OwnerOf(_weaponId));
        require(AlienType.level > 1);
        require(CheckWeaponsPresent() = false);
        CreateWeapons();
        AlienType.attack = AlienType.attack + add(10);
        delete _weaponId;
    }



}
