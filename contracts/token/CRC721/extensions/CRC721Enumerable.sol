// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

abstract contract CRC721Enumerable is ERC721Enumerable {
    using Math for uint256;

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
     * @dev Returns token IDs of specified `owner` in pagination view.
     */
    function tokensOf(
        address owner,
        uint256 offset,
        uint256 limit
    ) public view virtual returns (uint256 total, uint256[] memory tokenIds) {
        total = balanceOf(owner);
        if (total == 0 || offset >= total) {
            return (total, new uint256[](0));
        }

        uint256 endExclusive = total.min(offset + limit);
        tokenIds = new uint256[](endExclusive - offset);

        for (uint256 i = offset; i < endExclusive; i++) {
            tokenIds[i - offset] = tokenOfOwnerByIndex(owner, i);
        }
    }
}
