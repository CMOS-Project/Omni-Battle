pragma solidity ^0.4.16;

import "./safemath.sol";
import "./AlienSpawn.sol";
import "./ERC721.sol";

contract AlienOwnership is safemath, ERC721 {

    modifier AlienOwner(address Owner) {
       require(msg.sender == _Nebuli);
       _;
    }

    function getBalance(_OwnedAliens) public returns (uint) {    /// #DEV Call to get number of aliens
      return balanceOf(_Nebuli);
    }

}
