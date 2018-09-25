pragma solidity ^0.4.16;

import "./AlienSpawner.sol";
import "./Levels.sol";
import "./interest.sol";
import "./ERC721.sol";
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";


///#DEV Once a corebase reaches full capacity, the user is forced to upgrade. They must send a tx with Nebuli. 
/*
10 Aliens = Lv1
20 = Lv2
50 = Lv3
100 = Lv4
200 = Lv5
500 = Lv6
1000 = Lv7
2500 = Lv8
5000 = Lv9
10000+ = Lv10
*/


contract CoreBaseUpgrade is CreateCoreBase, Levels, interest, ERC721X, usingOraclize {
    
    Nebuli Interface
    ERC20Interface NebuliToken;
    CoreBaseUpgrade(address ContractAddress = 0x0CEe578DD572CaA9c83dE4C9eD6A5e8703ceB1Df); 
    NebuliToken(ContractAddress);
    }
    
    event UpgradeBase(uint CoreBaseId);
    event Transfer(msg.sender, address ContractAddress, msg.value);
    
    function UpgradeWaitTime(_CoreBaseId) {
      oraclize_query = (CoreBase.RegenRate, "URL", ""); ///#DEV No data to fetch externally. Only wait time important.
    }
    
    function __callback(bytes32 myid, string result) internal {
       if (msg.sender != oraclize_cbAddress()) throw();
       UpgradeBase(_CoreBaseId);
    }
       
    
    function TriggerUpgrade(_CoreBaseId) internal {
       require(msg.sender == OwnerOf(_CoreBaseId));
       require(msg.value = 200); // User sends 200NBL
       uint amount = transfer(_ContractAddress , _msg.value);
       __callback(_myid, _result);  // User transfers 200 NBL to contract address. Wait however long new regen time is. Likely incorrect. (Mighty)
    }
    
    
    function CheckLevelBaseUpgrade(_CoreBaseId, _AlienId) internal {
        require(msg.sender == OwnerOf(_CoreBaseId));
        if(balanceOf(msg.sender, _AlienId) >= 10) {
           Alien storage Level = 1;
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 20) {
           Alien storage Level = 2; 
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 50) {
           Alien storage Level = 3;
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 100) {
           Alien storage Level = 4; 
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 200) {
            Alien storage Level = 5;
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 500) {
            Alien storage Level = 6;
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 1000) {
            Alien storage Level = 7;
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 2500) {
            Alien storage Level = 8;
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 5000) {
            Alien storage Level = 9;
        }
        
        else if(balanceOf(msg.sender, _AlienId) >= 10000) {
            Alien storage Level = 10;
        }
        
        else {
            Alien storage Level = 0;
        }
    }
    
    function CompareLevelBase() returns view (bool) {
        if(Alien storage Level > CoreBase.level ) {
            return true;
        }
        else {
            return false;
        }
    }
    
    function CoreBaseUpgrade(_CoreBaseId) internal {
        require(msg.sender == OwnerOf(_CoreBaseId));
        require(CompareLevelBase() = true);
        TriggerUpgrade(_CoreBaseId);
        CreateRandomAlien(_name, _AlienSub, _attack, _defence, _level, _armor, _AttackCooldown, _AmalgamationCooldown); ///#DEV Give user 1 Alien upon upgrade 
        CoreBase.level++;
        CoreBase.RegenRate = CoreBase.RegenRate / 1.1; ///#DEV CoreBase regen from attacks is reduced from each subsequent upgrade
    }
    
    /*function CheckUpgrade(_CoreBaseId) returns view (bool) {
        require(msg.sender == OwnerOf(_CoreBaseId));
        if(CoreBaseUpgrade() ) {
            
        }
        
        else {
            
        }
    }*/
    
    
    
}