// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IMockPoSRegister {
  function register(bytes32 indentifier, uint64 votePower, bytes calldata blsPubKey, bytes calldata vrfPubKey, bytes[2] calldata blsPubKeyProof) external payable;
  function increaseStake(uint64 votePower) external;
  function retire(uint64 votePower) external;
  function getVotes(bytes32 identifier) external view returns (uint256, uint256);
  function addressToIdentifier(address addr) external view returns (bytes32);
  function identifierToAddress(bytes32 identifier) external view returns (address);
}