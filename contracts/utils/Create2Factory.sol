// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev This contract is used to deploy smart contracts with create2 op code.
 * It was introduced in https://github.com/Conflux-Chain/CIPs/blob/master/CIPs/cip-31.md
 * It is deployed at Conflux's genesis block
 * its address is 0x8A3A92281Df6497105513B18543fd3B60c778E40
 */
contract Create2Factory {
    /* solhint-disable private-vars-leading-underscore */
    mapping(address => bool) deployed;

    /**
     * @dev Check whether a address is deployed with Create2Factory
     * @param addr The address to check
     */
    function isDeployed(address addr) public view virtual returns (bool) {
        return deployed[addr];
    }

    /**
     * @dev Deploy smart contract with create2 op code
     * @param code The code to deploy
     * @param salt The salt used to generate contract address
     */
    function deploy(bytes memory code, uint256 salt) public virtual returns (address) {
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
