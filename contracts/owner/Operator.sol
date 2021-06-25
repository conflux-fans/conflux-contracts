pragma solidity ^0.6.2;

import '@openzeppelin/contracts/GSN/Context.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract Operator is Context, Ownable {
    address private _operator;

    mapping(address => bool) public miners;
    mapping(address => bool) public managers;

    event OperatorTransferred(
        address indexed previousOperator,
        address indexed newOperator
    );

    constructor() internal {
        _operator = _msgSender();
        emit OperatorTransferred(address(0), _operator);
    }

    function operator() public view returns (address) {
        return _operator;
    }

    modifier onlyMiner(){
        require(miners[_msgSender()],"MinterRole: caller does not have the Minter role or above");
        _;
    }
  
    //chy add
    modifier onlyManager(){
        require(managers[_msgSender()],"ManagerRole: caller does not have the Manager role or above");
        _;
    }

    modifier onlyOperator() {
        require(
            _operator == msg.sender,
            'operator: caller is not the operator'
        );
        _;
    }

    function addMiner(address _miner) public onlyOwner(){
        miners[_miner] = true;
    }

    function removeMiner(address _miner) public onlyOwner(){
        miners[_miner] = false;
    }

    function addManager(address _manager) public onlyOwner(){
        managers[_manager] = true;
    }

    function removeManager(address _manager) public onlyOwner(){
        managers[_manager] = false;
    }

    function isOperator() public view returns (bool) {
        return _msgSender() == _operator;
    }

    function transferOperator(address newOperator_) public onlyOwner {
        _transferOperator(newOperator_);
    }

    function _transferOperator(address newOperator_) internal {
        require(
            newOperator_ != address(0),
            'operator: zero address given for new operator'
        );
        emit OperatorTransferred(address(0), newOperator_);
        _operator = newOperator_;
    }
}
