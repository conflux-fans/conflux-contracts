// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./AdminControl.sol";
import "./SponsorWhitelistControl.sol";
import "./Staking.sol";
import "./ConfluxContext.sol";
import "./PoSRegister.sol";
import "./CrossSpaceCall.sol";
import "./ParamsControl.sol";

/**
 * @dev This library includes initialized Internal Contract instance.
 */
library InternalContracts {
    /**
     * @dev adminControl
     */
    AdminControl public constant ADMIN_CONTROL = AdminControl(0x0888000000000000000000000000000000000000);

    /**
     * @dev sponsorControl
     */
    SponsorWhitelistControl public constant SPONSOR_CONTROL =
        SponsorWhitelistControl(0x0888000000000000000000000000000000000001);

    /**
     * @dev staking
     */
    Staking public constant STAKING = Staking(0x0888000000000000000000000000000000000002);

    /**
     * @dev ConfluxContext
     */
    ConfluxContext public constant CONFLUX_CONTEXT = ConfluxContext(0x0888000000000000000000000000000000000004);

    /**
     * @dev PoSRegister
     */
    PoSRegister public constant POS_REGISTER = PoSRegister(0x0888000000000000000000000000000000000005);

    /**
     * @dev CrossSpaceCall
     */
    CrossSpaceCall public constant CROSS_SPACE_CALL = CrossSpaceCall(0x0888000000000000000000000000000000000006);

    /**
     * @dev CrossSpaceCall
     */
    ParamsControl public constant PARAMS_CONTROL = ParamsControl(0x0888000000000000000000000000000000000007);
}
