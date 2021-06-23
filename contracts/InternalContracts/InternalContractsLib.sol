// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./AdminControl.sol";
import "./SponsorWhitelistControl.sol";
import "./Staking.sol";

/**
 * @dev This library includes initialized Internal Contract instance.
 */
library IContracts {
    /**
     * @dev adminControl
     */
    AdminControl constant adminControl =
        AdminControl(0x0888000000000000000000000000000000000000);

    /**
     * @dev sponsorControl
     */
    SponsorWhitelistControl constant sponsorControl =
        SponsorWhitelistControl(0x0888000000000000000000000000000000000001);

    /**
     * @dev staking
     */
    Staking constant staking =
        Staking(0x0888000000000000000000000000000000000002);
}
