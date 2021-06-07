// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../utils/ERC1820Context.sol";
import "./SponsorWhitelistControl.sol";
import "./AdminControl.sol";

/**
 * @dev Provides default configurations for Conflux internal contracts.
 */
abstract contract InternalContractsHandler is ERC1820Context {

    constructor() {
        if (!_cfxChain) {
            return;
        }

        // Support to sponsor all users by default.
        address[] memory users = new address[](1);
        users[0] = address(0);
        SponsorWhitelistControl(0x0888000000000000000000000000000000000001).addPrivilege(users);

        // remove contract admin
        AdminControl ac = AdminControl(0x0888000000000000000000000000000000000000);
        ac.setAdmin(address(this), address(0));
        require(
            ac.getAdmin(address(this)) == address(0),
            "require admin == null"
        );
    }

}