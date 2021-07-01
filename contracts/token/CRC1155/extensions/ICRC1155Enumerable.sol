// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

/**
 * @dev Extension of ERC1155 to allow enumerability.
 */
interface ICRC1155Enumerable is IERC1155 {
    /**
     * @dev Returns the number of different tokenIds stored by the contract.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the `index`-th tokenId stored by the contract.
     */
    function tokenByIndex(uint256 index) external view returns (uint256);

    /**
     * @dev Returns the total amount of tokens for the specified `tokenId`.
     */
    function totalSupply(uint256 tokenId) external view returns (uint256);

    /**
     * @dev Indicates whether the specified `tokenId` exists or not.
     */
    function exists(uint256 tokenId) external view returns (bool);

    /**
     * @dev Returns the number of token ids held by `owner`.
     */
    function tokenCountOf(address owner) external view returns (uint256);

    /**
     * @dev Returns the `index`-th tokenId held by `owner`.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
}
