// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";

/**
 * @dev Aggregate results from multiple read-only function calls.
 */
contract Multicall {
    using Address for address;

    struct Call {
        address target;
        bytes callData;
    }

    struct Result {
        bool success;
        bytes returnData;
    }

    function _staticCall(
        bool requireSuccess,
        address target,
        bytes memory data
    ) internal virtual view returns (Result memory) {
        require(target.isContract(), "Multicall: static call to non-contract");

        (bool success, bytes memory returnData) = target.staticcall(data);

        if (requireSuccess && !success) {
            if (returnData.length == 0) {
                revert("Multicall: static call failed");
            }

            assembly {
                let returnDataSize := mload(returnData)
                revert(add(32, returnData), returnDataSize)
            }
        }

        return Result(success, returnData);
    }

    function aggregate(address target, bytes[] memory calldatas) public view virtual returns (bytes[] memory) {
        bytes[] memory results = new bytes[](calldatas.length);

        for (uint256 i = 0; i < calldatas.length; i++) {
            results[i] = _staticCall(true, target, calldatas[i]).returnData;
        }

        return results;
    }

    function aggregate(address[] memory targets, bytes[] memory calldatas) public view virtual returns (bytes[] memory) {
        require(targets.length == calldatas.length, "targets and calldatas length mismatch");

        bytes[] memory results = new bytes[](calldatas.length);

        for (uint256 i = 0; i < calldatas.length; i++) {
            results[i] = _staticCall(true, targets[i], calldatas[i]).returnData;
        }

        return results;
    }

    function aggregate(Call[] memory calls) public view virtual returns (bytes[] memory) {
        bytes[] memory results = new bytes[](calls.length);

        for (uint256 i = 0; i < calls.length; i++) {
            results[i] = _staticCall(true, calls[i].target, calls[i].callData).returnData;
        }

        return results;
    }

    function aggregate(
        bool requireSuccess,
        address target,
        bytes[] memory calldatas
    ) public view virtual returns (Result[] memory) {
        Result[] memory results = new Result[](calldatas.length);

        for (uint256 i = 0; i < calldatas.length; i++) {
            results[i] = _staticCall(requireSuccess, target, calldatas[i]);
        }

        return results;
    }

    function aggregate(
        bool requireSuccess,
        address[] memory targets,
        bytes[] memory calldatas
    ) public view virtual returns (Result[] memory) {
        Result[] memory results = new Result[](calldatas.length);

        for (uint256 i = 0; i < calldatas.length; i++) {
            results[i] = _staticCall(requireSuccess, targets[i], calldatas[i]);
        }

        return results;
    }

    function aggregate(bool requireSuccess, Call[] memory calls) public view virtual returns (Result[] memory) {
        Result[] memory results = new Result[](calls.length);

        for (uint256 i = 0; i < calls.length; i++) {
            results[i] = _staticCall(requireSuccess, calls[i].target, calls[i].callData);
        }

        return results;
    }
}
