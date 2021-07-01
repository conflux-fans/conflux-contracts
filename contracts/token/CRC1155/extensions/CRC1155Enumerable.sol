// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ICRC1155Enumerable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

abstract contract CRC1155Enumerable is ERC1155, ICRC1155Enumerable {
    using EnumerableSet for EnumerableSet.UintSet;
    using Math for uint256;

    // All token ids for enumeration.
    EnumerableSet.UintSet private _allTokens;

    // Mapping from token ID to token total supply.
    mapping(uint256 => uint256) private _totalSupplies;

    // Mapping from owner to owned token IDs for enumeration.
    mapping(address => EnumerableSet.UintSet) private _ownedTokens;

    /**
     * @dev Returns the number of different tokenIds stored by the contract.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _allTokens.length();
    }

    /**
     * @dev Returns the `index`-th tokenId stored by the contract.
     */
    function tokenByIndex(uint256 index) public view virtual override returns (uint256) {
        return _allTokens.at(index);
    }

    /**
     * @dev Returns token IDs in pagination view.
     */
    function tokens(uint256 offset, uint256 limit)
        public
        view
        virtual
        returns (uint256 total, uint256[] memory tokenIds)
    {
        total = totalSupply();
        if (total == 0 || offset >= total) {
            return (total, new uint256[](0));
        }

        uint256 endExclusive = total.min(offset + limit);
        tokenIds = new uint256[](endExclusive - offset);

        for (uint256 i = offset; i < endExclusive; i++) {
            tokenIds[i - offset] = tokenByIndex(i);
        }
    }

    /**
     * @dev Returns the total amount of tokens for the specified `tokenId`.
     */
    function totalSupply(uint256 tokenId) public view virtual override returns (uint256) {
        return _totalSupplies[tokenId];
    }

    /**
     * @dev Indicates whether the specified `tokenId` exists or not.
     */
    function exists(uint256 tokenId) public view virtual override returns (bool) {
        return _totalSupplies[tokenId] > 0;
    }

    /**
     * @dev Returns the number of token ids held by `owner`.
     */
    function tokenCountOf(address owner) public view virtual override returns (uint256) {
        return _ownedTokens[owner].length();
    }

    /**
     * @dev Returns the `index`-th tokenId held by `owner`.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view virtual override returns (uint256) {
        return _ownedTokens[owner].at(index);
    }

    /**
     * @dev Returns token IDs of specified `owner` in pagination view.
     */
    function tokensOf(
        address owner,
        uint256 offset,
        uint256 limit
    ) public view virtual returns (uint256 total, uint256[] memory tokenIds) {
        total = tokenCountOf(owner);
        if (total == 0 || offset >= total) {
            return (total, new uint256[](0));
        }

        uint256 endExclusive = total.min(offset + limit);
        tokenIds = new uint256[](endExclusive - offset);

        for (uint256 i = offset; i < endExclusive; i++) {
            tokenIds[i - offset] = tokenOfOwnerByIndex(owner, i);
        }
    }

    /**
     * @dev Update enumerability data in hook.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);

        for (uint256 i = 0; i < ids.length; ++i) {
            uint256 tokenId = ids[i];
            uint256 amount = amounts[i];

            // do nothing if amount == 0 or transfer to self
            if (amount == 0 || from == to) {
                continue;
            }

            // handle for the from address
            if (from == address(0)) {
                // mint token
                uint256 supply = _totalSupplies[tokenId];
                if (supply == 0) {
                    _allTokens.add(tokenId);
                }
                _totalSupplies[tokenId] = supply + amount;
            } else if (balanceOf(from, tokenId) == amount) {
                // all transferred
                _ownedTokens[from].remove(tokenId);
            }

            // handle for the to address
            if (to == address(0)) {
                // burn token
                _totalSupplies[tokenId] -= amount;
                if (_totalSupplies[tokenId] == 0) {
                    _allTokens.remove(tokenId);
                }
            } else if (balanceOf(to, tokenId) == 0) {
                // new token owned
                _ownedTokens[to].add(tokenId);
            }
        }
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(IERC165, ERC1155) returns (bool) {
        return interfaceId == type(ICRC1155Enumerable).interfaceId || super.supportsInterface(interfaceId);
    }
}
