// SPDX-License-Identifier: MIT
pragma solidity >=0.4.15;

interface SponsorWhitelistControl {
    /*** Query Functions ***/
    /**
     * @dev get gas sponsor address of specific contract
     * @param contractAddr The address of the sponsored contract
     */
    function getSponsorForGas(address contractAddr) external view returns (address);

    /**
     * @dev get current Sponsored Balance for gas
     * @param contractAddr The address of the sponsored contract
     */
    function getSponsoredBalanceForGas(address contractAddr) external view returns (uint256);

    /**
     * @dev get current Sponsored Gas fee upper bound
     * @param contractAddr The address of the sponsored contract
     */
    function getSponsoredGasFeeUpperBound(address contractAddr) external view returns (uint256);

    /**
     * @dev get collateral sponsor address
     * @param contractAddr The address of the sponsored contract
     */
    function getSponsorForCollateral(address contractAddr) external view returns (address);

    /**
     * @dev get current Sponsored Balance for collateral
     * @param contractAddr The address of the sponsored contract
     */
    function getSponsoredBalanceForCollateral(address contractAddr) external view returns (uint256);

    /**
     * @dev check if a user is in a contract's whitelist
     * @param contractAddr The address of the sponsored contract
     * @param user The address of contract user
     */
    function isWhitelisted(address contractAddr, address user) external view returns (bool);

    /**
     * @dev check if all users are in a contract's whitelist
     * @param contractAddr The address of the sponsored contract
     */
    function isAllWhitelisted(address contractAddr) external view returns (bool);

    /*** for contract admin only **/
    /**
     * @dev contract admin add user to whitelist
     * @param contractAddr The address of the sponsored contract
     * @param addresses The user address array
     */
    function addPrivilegeByAdmin(address contractAddr, address[] memory addresses) external;

    /**
     * @dev contract admin remove user from whitelist
     * @param contractAddr The address of the sponsored contract
     * @param addresses The user address array
     */
    function removePrivilegeByAdmin(address contractAddr, address[] memory addresses) external;

    // ------------------------------------------------------------------------
    // Someone will sponsor the gas cost for contract `contractAddr` with an
    // `upper_bound` for a single transaction.
    // ------------------------------------------------------------------------
    function setSponsorForGas(address contractAddr, uint256 upperBound) external payable;

    // ------------------------------------------------------------------------
    // Someone will sponsor the storage collateral for contract `contractAddr`.
    // ------------------------------------------------------------------------
    function setSponsorForCollateral(address contractAddr) external payable;

    // ------------------------------------------------------------------------
    // Add commission privilege for address `user` to some contract.
    // ------------------------------------------------------------------------
    function addPrivilege(address[] memory) external;

    // ------------------------------------------------------------------------
    // Remove commission privilege for address `user` from some contract.
    // ------------------------------------------------------------------------
    function removePrivilege(address[] memory) external;
}
