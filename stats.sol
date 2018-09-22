pragma solidity ^0.4.16;

import "./AlienSpawner.sol";
import "./Levels.sol";


contract Stats is AlienSpawner, Levels {

    string err = "ERROR getting stats";

    function Averages() internal {
      require(msg.sender == OwnerOf(_CoreBaseId));
      uint LevTotal;
      uint AttTotal;
      uint DefTotal;

      for(uint i=0; i < CoreBase[0][6].length; i++) {
        LevTotal += CoreBase.Aliens[i].levels;
        AttTotal += CoreBase.Aliens[i].attack;
        DefTotal += CoreBase.Aliens[i].defence;

      }

     uint AverageLevel = _LevTotal / CoreBase.AlienCount;
     uint AverageAttack = _AttTotal / CoreBase.AlienCount;
     uint AverageDefence = _DefTotal / CoreBase.AlienCount;
    }

    function CoreBaseCount() returns(uint) {
        if(CoreBase.Aliens.length = CoreBase.AlienCount) {
            return CoreBase.AlienCount;
        }
        else {
            return err;
        }
    }

}
