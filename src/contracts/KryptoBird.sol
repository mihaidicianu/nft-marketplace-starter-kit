// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector{

    string[] public kryptoBirdz;

    mapping (string => bool) _kryptoBirdExists;

    function mint(string memory _KryptoBird) public {
        require(!_kryptoBirdExists[_KryptoBird], "KryptoBird already exists");
        
        //uint _id = KryptoBirdz.push(_KryptoBird);
        kryptoBirdz.push(_KryptoBird);
        uint _id = kryptoBirdz.length - 1;
        
        _mint(msg.sender, _id);
        _kryptoBirdExists[_KryptoBird] = true;
    }

    constructor() ERC721Connector("KryptoBird", "KBIRZ"){

    }

}