// SPDX-License-Identifier: MIT
// Forked from
// OpenZeppelin Contracts (last updated v4.7.0) (utils/Create2.sol)

pragma solidity ^0.8.0;

/**
 * precompute contract address deployed by sending a transaction
 * Conflux computes contract address in a different way from ethereum
 * (visit https://www.confluxnetwork.org/files/Conflux_Protocol_Specification.pdf 6.3 contract creation for more details)
 *
 * Modified from OpenZeppelin Contracts' computeAddress of Create2.sol
 */
library Precompute {
    function changeEndian(uint256 val) internal pure returns (uint256) {
        bytes32 input = bytes32(val);
        uint256 result = 0;
        for (uint8 i = 0; i < 32; i = i + 1) {
            result = result | uint256(uint256(uint8(input[i])) << (i * 8));
        }
        return result;
    }

    function computeAddressUsingNonce(
        uint256 nonce,
        bytes32 bytecodeHash,
        address deployer
    ) internal pure returns (address addr) {
        // nonce should be encoded in Little Endian
        uint256 nonceLE = changeEndian(nonce);
        // the following assembly does:
        // addr = address(uint160(uint(keccak256(
        //     abi.encodePacked(bytes1(0x00), deployer, bytes32(nonce), bytecodeHash)
        // ))));
        assembly {
            let ptr := mload(0x40) // Get free memory pointer

            // |                   | ↓ ptr ...  ↓ ptr + 0x0B (start) ...  ↓ ptr + 0x20 ...  ↓ ptr + 0x40 ...   |
            // |-------------------|---------------------------------------------------------------------------|
            // | bytecodeHash      |                                                        CCCCCCCCCCCCC...CC |
            // | nonceLE           |                                      BBBBBBBBBBBBB...BB((LittleEndian))   |
            // | deployer          | 000000...0000AAAAAAAAAAAAAAAAAAA...AA                                     |
            // | 0x00              |            00                                                             |
            // |-------------------|---------------------------------------------------------------------------|
            // | memory            | 000000...0000AAAAAAAAAAAAAAAAAAA...AABBBBBBBBBBBBB...BBCCCCCCCCCCCCC...CC |
            // | keccak(start, 85) |            ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ |

            mstore(add(ptr, 0x40), bytecodeHash)
            mstore(add(ptr, 0x20), nonceLE)
            mstore(ptr, deployer) // Right-aligned with 12 preceding garbage bytes
            let start := add(ptr, 0x0b) // The hashed data starts at the final garbage byte which we will set to 0xff
            mstore8(start, 0x00)
            addr := keccak256(start, 85)
        }
        // convert the first byte to 0x8
        addr = address((uint160(addr) & ((1 << 156) - 1)) | (1 << 159));
    }
}
