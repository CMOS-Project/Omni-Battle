pragma solidity ^0.4.24;
import "../openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "../openzeppelin-solidity/contracts/token/ERC20/StandardBurnableToken.sol";
import "../openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "../openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "../erc721x/contracts/Interfaces/ERC721X.sol";

// ----------------------------------------------------------------------------
// Nebuli token contract for the Omiron Project
//
// Deployed to : 0xf3966096Bf0e29c259d9A500907d91a7DFDD1148
// Symbol      : NBL
// Name        : Nebuli
// Total supply: 50000000
// Decimals    : 18
//

contract Safe {

    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}


/*contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}*/


contract ApproveAndCallFallBack {
    function receiveApproval(address from, uint256 tokens, address token, bytes data) public;
}



contract NebuliToken is DetailedERC20, Ownable, Safe {

  ERC721X private ERC721XImplement;

constructor(address erc721xaddress) public {
    ERC721XImplement = ERC721X(erc721xaddress);
  }

    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;



    function Nebuli() public {
        symbol = "NBL";
        name = "Nebuli Token";
        decimals = 18;
        _totalSupply = 50000000000000000000000000;
        //balances[] = _totalSupply;
        emit Transfer(address(0), 0x4D169c8dC03873931ab4147540e7dACFA86eEb84, _totalSupply);
    }
}
