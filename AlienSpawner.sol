pragma solidity ^0.4.16;

import "./AlienOwnership.sol";
import "./safemath.sol";
import "./ERC721.sol";



/// #CONTRACT Create the Aliens contract
contract AlienSpawner is SafeMath, ERC721 {


    uint Combos = 20;
    uint Total = 20 ** Combos ; /// #DEV Total combos of Alien type 1
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


struct Armor{
    uint defence;
    uint durability;
    uint64 DefenceCooldown;
}

struct Weapons{
    uint attack;
}

struct CoreBase{
    uint hp;
    uint RegenRate;
}

AlienType[] alien; ///#DEV Aliens array

function CreateRandomAlien() private {
    alien.push(AlienType[_name, _AlienSub, _attack, _defence, 5, 5, uint64(_AttackCooldown + _AmalgamationCooldown)] - 1); ///#DEV Add alien (Name, attack score, defence score, level, armor boost, cooldown between attacks, hybrid creation, start at index 0)
}

string _str;

function GetAlienRand() private returns(uint) {
    require(balanceOf(msg.sender) <= 3);
    return  _str == keccak256(_str);

    uint (msg.sender) == uint(keccak256(_str));/// #DEV First time users can generate 3 aliens to start off with
     /// #DEV Generates a random 256 bit string
}


    function TypeOfAlien(uint _defence, uint _attack, string _AlienType) private  {
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
      _defence = _defence + add(5);  /// #DEV Safe math. Adds +5 defence
      _AlienSub = keccak256("Anorak");  /// #DEV Higher than average defence
    }

    else if(counter_y > 7 && counter_x <= 8) {
      _attack = _attack + add(5);        /// #DEV Safe math. Adds +5 attack
      _AlienSub = keccak256("Varg");        /// #DEV If more than 15 Ys
                                       /// #DEV Higher than average attack
    }

    else if(counter_x > 7 && counter_y <= 8) {
       _defence = _defence + add(5);
       _attack = _attack + add(5);               /// #DEV
       _AlienSub = keccak256("Zorg");/// #DEV If more than 15Xs and 15Ys
                                 /// #DEV All rounded
    }

    else {
        _AlienType = keccak256("Regular");
        /// #DEV Common Starter
    }

    CreateRandomAlien(_AlienNum, _name, _attack, _defence, _AttackCooldown, _sub);
}






}









}
