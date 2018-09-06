pragma solidity ^0.4.16;

import "./draft.sol";


contract ERC721 {   ///#DEV ERC 721 token standard
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed Nebuli, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _Nebuli) public view returns (uint256 _balance);
  function ownerOf(uint256 _tokenId) public view returns (address _owner);
  function transfer(address _to, uint256 _tokenId) public;
  function approve(address _to, uint256 _tokenId) public;
  function takeOwnership(uint256 _tokenId) public;
}
