// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC165.sol';

contract ERC165 is IERC165{

    mapping (bytes4 => bool) private _supportedInterfaces;
    
    constructor(){
        _registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }

    function supportsInterface(bytes4 interfaceID) external override view returns (bool){
        if(interfaceID == 0xFFFFFFFF){
            return false;
        }
        return _supportedInterfaces[interfaceID];    
    }

    function _registerInterface(bytes4 interfaceId) public {
        require(interfaceId != 0xffffffff, "ERC165: Invalid interface");
        _supportedInterfaces[interfaceId] = true;
    }


}