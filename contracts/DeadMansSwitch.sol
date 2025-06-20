// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DeadMansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastCheckIn;
    uint256 public timeoutPeriod;

    constructor(address _beneficiary, uint256 _timeoutPeriod) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        timeoutPeriod = _timeoutPeriod;
        lastCheckIn = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function checkIn() external onlyOwner {
        lastCheckIn = block.timestamp;
    }

    function updateBeneficiary(address _newBeneficiary) external onlyOwner {
        beneficiary = _newBeneficiary;
    }

    function triggerSwitch() external {
        require(block.timestamp > lastCheckIn + timeoutPeriod, "Owner still active");
        payable(beneficiary).transfer(address(this).balance);
    }

    receive() external payable {}
}
