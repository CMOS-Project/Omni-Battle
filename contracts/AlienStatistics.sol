pragma solidity ^0.4.24;

import "./AlienSpawner.sol";

contract AlienStatistics is AlienCreation {

///#DEV Return Alien Count
function AlienCount() public view returns (uint) {
return TotalCount[msg.sender];
}


}
