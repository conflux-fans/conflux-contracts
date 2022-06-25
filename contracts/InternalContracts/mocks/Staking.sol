// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MockStaking {
    using SafeMath for uint256;

    address private _admin;
    mapping(address => uint256) private _userStakes;

    constructor() {
      _admin = msg.sender;
    }

    /*** Query Functions ***/
    /**
     * @dev get user's staking balance
     * @param user The address of specific user
     */
    function getStakingBalance(address user) public view returns (uint256) {
      return _userStakes[user];
    }

    // NOTE: need send ether when call this method
    function deposit(uint256 amount) public payable {
      require(msg.value == amount, "Invalid value");
      _userStakes[msg.sender] = _userStakes[msg.sender].add(amount);
    }

    function withdraw(uint256 amount) public {
      require(_userStakes[msg.sender] >= amount, "Insufficient balance");
      _userStakes[msg.sender] = _userStakes[msg.sender].sub(amount);
      address payable receiver = payable(msg.sender);
      receiver.transfer(amount);
    }

    /**
     * @dev get user's locked staking balance at given blockNumber
     * @param user The address of specific user
     * @param blockNumber The blockNumber as index.
     */
    function getLockedStakingBalance(address user, uint256 blockNumber) public pure returns (uint256) {
      // TODO implement
      return 0;
    }

    /**
     * @dev get user's vote power staking balance at given blockNumber
     * @param user The address of specific user
     * @param blockNumber The blockNumber as index.
     */
    function getVotePower(address user, uint256 blockNumber) public pure returns (uint256) {
      // TODO implement
      return 0;
    }

    function voteLock(uint256 amount, uint256 unlockBlockNumber) external {
      require(false, "Not implemented");
      // TODO
    }

    // =================== Debug method ========================

    function _addInterest() public payable {
      require(msg.sender == _admin, "Only admin can add interest");
    }

    // send one user's interest
    /* function _sendUserInterest(address _user) public payable {
      require(msg.sender == _admin, "Only admin can add interest");
      require(_userStakes[_user] > 0, "User has no staking balance");

      uint256 interest = _userStakes[_user].mul(400).div(10000);  // TODO use a more realistic interest rate
      address payable receiver = payable(_user);
      receiver.transfer(interest);
    } */

    function _sendUserInterest(address _user, uint256 _value) public payable {
      require(msg.sender == _admin, "Only admin can add interest");
      require(_userStakes[_user] > 0, "User has no staking balance");

      address payable receiver = payable(_user);
      receiver.transfer(_value * 1 ether);
    }
}
