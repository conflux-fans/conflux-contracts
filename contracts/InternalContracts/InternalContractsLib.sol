// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./AdminControl.sol";
import "./SponsorWhitelistControl.sol";
import "./Staking.sol";

/**
 * @dev This library includes initialized Internal Contract instance.
 */
library InternalContracts {
    /**
     * @dev adminControl
     */
    AdminControl public constant ADMIN_CONTROL =
        AdminControl(0x0888000000000000000000000000000000000000);

    /**
     * @dev sponsorControl
     */
    SponsorWhitelistControl public constant SPONSOR_CONTROL =
        SponsorWhitelistControl(0x0888000000000000000000000000000000000001);

    /**
     * @dev staking
     */
    Staking public constant STAKING =
        Staking(0x0888000000000000000000000000000000000002);
}
