pragma solidity ^0.4.16;

import "./ERC721.sol";
import "./AlienSpawner.sol";

contract InterestCurrency {

       event VirtualBalance(uint OmniGold, uint OmniGoldId);

       mapping(address => uint) OmniGoldOwner;

    function VirtualPrinter(uint OmniGold) internal { ///#DEV Creation of ERC 721 token used exclusively for locking in value of the base
        address owner = msg.sender;
        uint OmniGoldId = OmniGold;
        OmniGoldOwner(_OmniGoldId);
        VirtualBalance(_OmniGold, _OmniGoldId);
    }

function AccruedInterest() internal {
    uint number = 0;
    numb[];

    if(now >= 1 weeks && CoreBase.hp = 100) {
        require(msg.sender == OwnerOf(_CoreId)); ///#DEV Check if owner of tokenmatches request to claim interest
        numb.push(1);
        CoreBase.interest++;
        VirtualPrinter(_OmniGold);
     /// #DEV Returns 1 new card
    }

    else if(now >= _time + 2 weeks && CoreBase.hp = 100) {
        require(msg.sender == OwnerOf(_CoreId));
        numb.push(2);
        for(uint i = 0; uint < numb.length; i = i + add(1)){
           CoreBase.interest++;
           VirtualPrinter(_OmniGold);
        }
    }

    else if(now >= _time + 3 weeks && CoreBase.hp = 100) {
        require(msg.sender == OwnerOf(_CoreId));
        numb.push(3);
        for(i = 0; uint < numb.length; i = i + add(1)){
            CoreBase.interest++;
            VirtualPrinter(_OmniGold);
        }
    }

    else if(now >= _time + 4 weeks && CoreBase.hp = 100) {
        require(msg.sender == OwnerOf(_CoreId));
        numb.push(4);
        for(i = 0; uint < numb.length; i = i + add(1)){
            CoreBase.interest++;
            VirtualPrinter(_OmniGold);
        }
    }

    else if(now >= _time + 5 weeks && CoreBase.hp = 100) {
        require(msg.sender == OwnerOf(_CoreId));
        numb.push(5);
        for(i = 0; uint < numb.length; i = i + add(1)){
            CoreBase.interest++;
            VirtualPrinter(_OmniGold);
    }
    }

    else if(now >= _time + 6 weeks && CoreBase.hp = 100) {
        numb.push(6);
    for(i = 0; uint < numb.length; i = i + add(1)){
        CoreBase.interest++;
    }
    }

    else {
        delete numb;
    }
}

function CheckVal() internal view returns (bool) {   ///#DEV Value is equal to 1
   if(VirtualPrinter.Val = 1) {
    return true; /// #DEV Should return true
    }
    else {
    return false;
    }
}

function RedeemOmniGold(_OmniGoldId, _AlienId) internal {
    require(msg.sender == OwnerOf(_AlienId));
    require(msg.sender == OwnerOf(_OmniGoldId));
    CheckVal() = true;
    CreateRandomAlien(_strand, _Aliensub, _name, _attack, _defence, _AttackCooldown);
    delete _OmniGoldId; /// #DEV Can only be used once. Value reset to 0 afterwards.
    }
}

















    
