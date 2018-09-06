pragma solidity ^0.4.16;      

import "./browser/draft.sol";
import "./ERC721";

contract InterestExample is BrowserDraft, ERC721 {

function AccruedInterest(_Nebuli , uint time) private returns {
    if(now >= _time + 1 weeks && CoreBase.hp = 100) {
        require(msg.sender = _Nebuli) ///#DEV Check if person with NBL address matches request to claim interest
       uint week1 = 1.001 * balanceOf(_Nebuli)
    return transfer(_Nebuli, _week1) /// #DEV Returns 0.1% interest
    }

    else if(now >= _time + 2 weeks && CoreBase.hp = 100) {
        require(msg.sender = _Nebuli)
        uint week2 = 1.002 * balanceOf(_Nebuli)
        return transfer(_Nebuli, _week2)
    }

    else if(now >= _time + 3 weeks && CoreBase.hp = 100) {
        require(msg.sender = _Nebuli)
        uint week3 = 1.003 * balanceOf(_Nebuli)
    return transfer(_Nebuli, _week3)
    }

    else if(now >= _time + 4 weeks && CoreBase.hp = 100) {
        require(msg.sender = _Nebuli)
        uint week4 = 1.004 * balanceOf(_Nebuli)
    return transfer(_Nebuli, _week4)
    }

    else if(now >= _time + 5 weeks && CoreBase.hp = 100) {
        require(msg.sender = _Nebuli)
        uint week5 = 1.005 * balanceOf(_Nebuli)
    return transfer(_Nebuli, _week5)
    }

    else if(now >= _time + 6 weeks && CoreBase.hp = 100) {
        require(msg.sender = _Nebuli)
        uint week6 = 1.006 * balanceOf(_Nebuli)
    return transfer(_Nebuli, _week6)
    }

     else {
         require(msg.sender = _Nebuli)
         _time = 0 days

    }
}
}
