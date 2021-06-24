// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ICRC1155Metadata.sol";

abstract contract CRC1155Metadata is ICRC1155Metadata {
    string private _name;
    string private _symbol;

    constructor(string memory tokenName, string memory tokenSymbol) {
        _name = tokenName;
        _symbol = tokenSymbol;
    }

    /**
     * @dev Returns the token collection name.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }
}
