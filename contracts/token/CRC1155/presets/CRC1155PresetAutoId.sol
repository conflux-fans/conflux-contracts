// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/presets/ERC1155PresetMinterPauser.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "../extensions/CRC1155Enumerable.sol";

/**
 * @dev This contract extends the preset ERC1155 of OpenZeppelin, including:
 *  - Allow the default admin role to update URI for all tokens.
 *  - More utilities to mint tokens with auto-generated ID (starts from 0).
 *  - Support enumerability operations on chain.
 *
 * @notice the gas/storage cost is very expensive to support the enumerable interface.
 * If there will be a large number of token IDs (e.g. more than 1,000,000), you'd better
 * to abandon the `CRC1155Enumerable` interface and achieve the enumerability off-chain.
 */
contract CRC1155PresetAutoId is ERC1155PresetMinterPauser, CRC1155Enumerable {
    using Counters for Counters.Counter;

    // Counter to auto generate token ID.
    Counters.Counter private _tokenIdTracker;

    constructor(string memory uri) ERC1155PresetMinterPauser(uri) {}

    /**
     * @dev Update the URI for all tokens.
     *
     * Requirements:
     *
     * - the caller must have the `DEFAULT_ADMIN_ROLE`.
     */
    function setURI(string memory newuri) public virtual {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "CRC1155Preset: must have admin role to set URI");
        _setURI(newuri);
    }

    /**
     * @dev Creates `amount` new tokens for `to` with auto-generated token ID and additional data.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(
        address to,
        uint256 amount,
        bytes memory data
    ) public virtual {
        mint(to, _tokenIdTracker.current(), amount, data);
        _tokenIdTracker.increment();
    }

    /**
     * @dev Creates tokens with auto-generated token IDs in batch.
     * @param to address to mint tokens.
     * @param amounts amount for each token ID to mint.
     * @param data Additional data used when `to` address is a contract.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mintBatch(
        address to,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual {
        uint256[] memory tokenIds = new uint256[](amounts.length);

        for (uint256 i = 0; i < amounts.length; i++) {
            tokenIds[i] = _tokenIdTracker.current();
            _tokenIdTracker.increment();
        }

        mintBatch(to, tokenIds, amounts, data);
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - each value in `amounts` should not be zero.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override(ERC1155PresetMinterPauser, CRC1155Enumerable) {
        for (uint256 i = 0; i < amounts.length; i++) {
            require(amounts[i] > 0, "CRC1155Preset: amount is zero");
        }

        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155PresetMinterPauser, CRC1155Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
