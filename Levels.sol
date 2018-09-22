pragma solidity ^0.4.16;

import "./AlienSpawner.sol";
import "./ERC721.sol";


contract Attack is AlienSpawner, ERC721 {

    // Write corebase cooldown function here

    //Write Alien attack cooldown function here
    mapping(uint => address) TargetCoreBase;


   function GetRandomId (_CoreBaseId, _TargetCoreBaseId, uint64 numb) {
       require(msg.sender == OwnerOf(_CoreBaseId));

   uint randomTargetId = uint(block.blockhash(block.number-1)) % _total;
   uint TargetCoreBaseId = _randomTargetId;
   TargetCoreBase[_TargetCoreBaseId];

   }

    function InvalidCoreBaseId() view returns (bool) { ///#DEV Check if TargetCoreBaseId is valid
        if(CoreBaseOwner(_CoreId) == _targetCoreBaseId) {
          return true;
        }
        else {
          return false;
        }
    }

    function SelectCoreBaseId(_CoreBaseId, _TargetCoreBaseId) internal {
        require(msg.sender == OwnerOf(_CoreBaseId));
        require(_TargetCoreBaseId <= _total);
        require(ValidCoreBaseId() = false);
        require(_CoreBaseId.level == _TargetCoreBase);

        TargetCoreBase storage _TargetCoreBaseId; /// #DEV Store ID for attack target

        }

    function Attack(_CoreBaseId, _TargetCoreBaseId) internal payable {
        require(msg.sender == OwnerOf(_CoreBaseId));
        require(msg.value == 5); //Add NBL later
        require(_CoreBaseId =! _TargetCoreBaseId);

    }

    function ProbabilityAttackWin(_CoreBaseId) { ///#DEV Probability based on total attack vs total defence
    require(msg.sender == OwnerOf(_CoreBaseId));
    if(_CoreBaseId.attack > _TargetCoreBaseId.defence) {

    }

    function ResultofAttack() {
      ProbabilityAttackWin();
      if(_TargetCoreBaseId.hp > 0) {
          _CoreBaseId.LossCounter++;
          _TargetCoreBaseId.WinCounter++;

      }
      else {

      }
    }

    function CheckRegenReady() view returns (bool) {
        if(AlienType.Attackcooldown >= now + AlienType.Attackcooldown) {
            return true;
        }
        else
            return false;
    }


    function CoreBaseReady() view returns (bool) {  ///
        if(Corebase.RegenRate >= now + CoreBase.RegenRate ) {
            return false;
        }
        else {
            return true;
        }
    }

    /*function CheckCoreBaseUpgrading() view returns (bool) {
        if() {
         return true;
        }
        else {
        return false;
        }
    }*/

    function UserAttack(_AlienId, _CoreBaseId) internal {
        require(msg.sender == OwnerOf(_AlienId));
        require(msg.sender == OwnerOf(_CoreBaseId));
        require(CoreBaseReady() = true);
        require(CheckRegenReady() = true);
        Alien storage UserAlien = AlienId;
        Alien storage TargetAlien = TargetAlienId; // Clarify target
        //Not finished

        if(CoreBase.hp = 100) {    ///#DEV CoreBase has full health
            CoreBase.WinCounter++;
            CoreBase.levels++;  ///#DEV CoreBase win counter increases by 1
            AlienType.level++;  ///#DEV Level increases by 1
        }
        else {
           CoreBase.LossCounter++; ///#DEV CoreBase loss counter increases by 1
           CoreBase.levels--;     ///#DEV  CoreBase goes down 1 level.
           AlienType.level--;     ///#DEV Alien goes down 1 level. (Naming rights still remain if above level 2)
        }

    }


}

contract LevelUp is AlienOwnership, CreateCoreBase, ERC721, safemath {

    event NewName(string _name);

    function CheckLevel() view returns (bool) {  ///#DEV Check Alien is level 2+
        if(AlienType.level > 2) {
            return true;
        }
        else {
            return false;
        }
    }

      function NameChange(_name, _AlienId) internal { ///#DEV Naming rights for alien
          require(msg.sender == OwnerOf(_AlienId));
          require(Checklevel() = true);
          Alien storage name = AlienType.name; ///#DEV Store user given name
          name = _name; ///#DEV User gives name to Alien
          NewName(_name);
        }

        function WeaponUpgrade(_AlienId) internal { ///#DEV Assign weapon to alien
            require(msg.sender == OwnerOf(_AlienId));
            require(CheckLevel() = true);
            AlienType.attack +=10;
        }



}
