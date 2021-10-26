// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/introspection/IERC1820Registry.sol";

/**
 * @dev Supports ERC1820 registry on both ETH and Conflux.
 */
abstract contract ERC1820Context {
    using Address for address;

    address private constant _ERC1820_REGISTRY_ETH = 0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24;
    address private constant _ERC1820_REGISTRY_CFX = 0x88887eD889e776bCBe2f0f9932EcFaBcDfCd1820;

    function _isCfxChain() internal view virtual returns (bool) {
        return !_ERC1820_REGISTRY_ETH.isContract();
    }

    function _erc1820Registry() internal view virtual returns (IERC1820Registry) {
        if (_isCfxChain()) {
            return IERC1820Registry(_ERC1820_REGISTRY_CFX);
        } else {
            return IERC1820Registry(_ERC1820_REGISTRY_ETH);
        }
    }
}
