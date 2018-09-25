pragma solidity ^0.4.16;

import "./AlienSpawner.sol";
import "./ERC721.sol";


contract Attack is AlienSpawner, ERC721 {

    //Write Alien attack cooldown function here
    
    uint bonus = 10;
    uint DefaultAttack = 50 + _bonus;
    
    
    function VictoryChance(_bonus, _CoreBaseId, _targetCoreBaseId) internal {
        
     if(CoreBase.value >= TargetCoreBase.value) {
        _bonus+=10; 
     }
     
     if(CoreBase.AlienCount >= TargetCoreBase.AlienCount) {
        _bonus+=5; 
     }
     
     if(CoreBase.level >= TargetCoreBase.level) {
        for(uint i=TargetCoreBase.level; CoreBase.level > i; i--) {
            _bonus+=5;
        }
     }
     
     else if(CoreBase.Value <= TargetCoreBase.value) {
         _bonus-=5;
     }
     
     else if(CoreBase.Value <= TargetCoreBase.value) {
         _bonus-=5;
     }
     
}
     

    function PseudoRandomGen() internal view returns (uint8) {
     return uint8(uint256(keccak256(block.timestamp, block.difficulty))%StoreIds.length + 1);
}
   
   function SelectRandomCoreId(uint TargetCoreBaseId) {
       require(msg.sender == OwnerOf(_CoreBaseId));
       require(_CoreBaseId.level == _TargetCoreBase);
       PseudoRandomGen();
       
       for(uint i=0; i<StoreIds.length; i++) {
       if(StoreIds[i] = PseudoRandomGen())  {
        _TargetCoreBaseId = PseudoRandomgen();
        TargetCoreBase storage _TargetCoreBaseId; 
       }
       
       else {
           return err;
       }
   }
   }
  
    // Sanity Check
    function InvalidCoreBaseId() view returns (bool) { ///#DEV Check if TargetCoreBaseId is valid
        if(CoreBaseOwner(_CoreId) == _targetCoreBaseId) { 
          return true;  
        }
        else {
          return false;  
        }
    }
    
    function ProbabilityAttackWin(_CoreBaseId, _TargetCoreBaseId) internal { ///#DEV Probability based on total attack vs total defence
    require(msg.sender == OwnerOf(_CoreBaseId));
    require(_CoreBaseId =! _TargetCoreBaseId);
    
    }
    
    function ResultofAttack(_CoreBaseId, _TargetCoreBaseId) external {
      ProbabilityAttackWin();
      if(_TargetCoreBaseId.hp > 0) {
          _CoreBase.LossCounter++;
          _CoreBase.interest = 0;
          _CoreBase.Aliens.used=true;
          triggerAlienCooldown();
      }
      else {
        _CoreBase.Aliens.used = true;
        _CoreBase.WinCounter++;
      }
    }
    
    function CheckRegenReady(_CoreBaseId) view returns (bool) {
        if(CoreBase.AlienType.Attackcooldown > now + CoreBase.AlienType.Attackcooldown) {  
            return true;
        }
        else
            return false;
    }
    
    
    function CoreBaseReady(_CoreBaseId) view returns (bool) {  ///
        if(Corebase.RegenRate > now + CoreBase.RegenRate ) {
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
    
    
    
    function UserAttackAlien(_AlienId, _CoreBaseId) internal {
        require(msg.sender == OwnerOf(_AlienId));
        require(msg.sender == OwnerOf(_CoreBaseId));
        require(CoreBaseReady() = true);
        require(CheckRegenReady() = true);
        Alien storage UserAlien = AlienId;
        Alien storage TargetAlien = TargetAlienId; 
        // Clarify target Not finished
        
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
    
    function CheckLevel(_AlienId) view returns (bool) {  ///#DEV Check Alien is level 2+
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
          NewName(_name); ///#DEV Event to show frontend Javascript result of newly named Alien
        }
        
        function WeaponUpgrade(_AlienId) internal { ///#DEV Assign weapon to alien
            require(msg.sender == OwnerOf(_AlienId));
            require(CheckLevel() = true);
            AlienType.attack +=10;
        }
        
}





