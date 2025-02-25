// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is IERC721Enumerable, ERC721{

    uint[] private _allTokens;

    mapping(uint => uint) private _allTokensIndex;
    mapping(address => uint[]) private _ownedTokens;
    mapping(uint => uint) private _ownedTokenIndex;
     
    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() external view returns (uint256){
        return _allTokens.length;
    }

    /// @notice Enumerate valid NFTs
    /// @dev Throws if `_index` >= `totalSupply()`.
    /// @param _index A counter less than `totalSupply()`
    /// @return The token identifier for the `_index`th NFT,
    ///  (sort order not specified)
    function tokenByIndex(uint256 _index) external view returns (uint256){
        require(_index < this.totalSupply(), "Index is out of range");
        return _allTokens[_index];
    }

    /// @notice Enumerate NFTs assigned to an owner
    /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
    ///  `_owner` is the zero address, representing invalid NFTs.
    /// @param _owner An address where we are interested in NFTs owned by them
    /// @param _index A counter less than `balanceOf(_owner)`
    /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
    ///   (sort order not specified)
    function tokenOfOwnerByIndex(address _owner, uint256 _index) public view returns (uint256){
        require( _index < balanceOf(_owner), 
            "Incorrect index or address");
        return _ownedTokens[_owner][_index];
    }

    function _mint(address to, uint tokenID) internal override(ERC721){
        super._mint(to, tokenID);
        _allTokensIndex[tokenID] =  _allTokens.length;
        _allTokens.push(tokenID);

        _ownedTokens[to].push(tokenID);
        _ownedTokenIndex[tokenID] = _ownedTokens[to].length; 

        
    }

}