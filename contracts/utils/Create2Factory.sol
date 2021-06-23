// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Create2Factory {
    mapping(address => bool) deployed;

    function isDeployed(address addr) public view returns (bool) {
        return deployed[addr];
    }

    function deploy(bytes memory code, uint256 salt) public returns (address) {
        address addr;
        bool success = true;
        assembly {
            addr := create2(0, add(code, 0x20), mload(code), salt)
            if iszero(extcodesize(addr)) {
                success := 0
            }
        }
        require(success, "create2 failed");
        require(!deployed[addr], "contract has been deployed before");
        deployed[addr] = true;
        return addr;
    }
}
