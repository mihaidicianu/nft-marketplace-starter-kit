// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721{
    /*
    Building out the minting function
        a. nft to point to an address
        b. keep track of the token ids
        c. keep track token owner address to token ids
        d. keep track of how many tokens an address
        e. create an event that emits a transfer log

    */

    //Mapping from token id to owner address
    mapping (uint => address) private tokenOwners;

    //Mapping from owner address to number of owned tokens
    mapping (address => uint) private ownedTokensCount;

    mapping (uint => address) private tokenApprovals;
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint indexed tokenID);

    function _mint(address to, uint tokenID) internal virtual {
        require(to != address(0), "ERC721: Address must not be 0!");
        require(tokenOwners[tokenID] == address(0), "ERC721: Token already minted");

        tokenOwners[tokenID] = to;
        ownedTokensCount[to] += 1;

        //emit Transfer
        emit Transfer(address(this), to, tokenID);
    }

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view returns (uint256){
        require(_owner != address(0), "ERC721: Adress must not be 0!");

        return ownedTokensCount[_owner];
    }

    
    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) public view returns (address){
        require(tokenOwners[_tokenId] != address(0), "ERC721: Adress must not be 0!");
        return tokenOwners[_tokenId];
    }

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable{
        require(_to != address(0), '');
        require(ownerOf(_tokenId) == _from, "From address does not own the NFT");
        require(msg.sender == tokenOwners[_tokenId] ||
                msg.sender == tokenApprovals[_tokenId] 
                ,"");

        tokenOwners[_tokenId] = _to;
        ownedTokensCount[_from]--;
        ownedTokensCount[_to]++;
        
        emit Transfer(_from, _to, _tokenId);
    }


}