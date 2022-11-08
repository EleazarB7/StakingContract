// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract StakeContract is Ownable {

    event Staked(address indexed user, uint216 amount); // Event signifying that the tokens are staked
    event Withdrawn(address indexed user, uint216 amount); // Event signifying that the tokens are withdrawn
    event InterestCompounded(address indexed user, uint216 amount); // Event signifying the interest


    address public MVPWAIR; //["0x71bDd3e52B3E4C154cF14f380719152fd00362E7"];
    uint256 factor = 1e11;
    uint256 delta = 3854;
    


    struct Stakedata{
        uint216 amountToStake;
        uint40 timeStaked;
        bool staked;
    }

    mapping(address => Stakedata) _stakeData;

    constructor(address _mvpwair) {
        MVPWAIR = _mvpwair;
    }

    // With this function users can stake their tokens
    function stake(uint216 amount) external{
        require(IERC20(MVPWAIR).transferFrom(msg.sender, address(this), amount));
        Stakedata storage sd  = _stakeData[msg.sender];
        if( sd.amountToStake > 0 ){
            uint216 currentReward = getInterest(msg.sender);
            sd.amountToStake += currentReward;
            emit InterestCompounded(msg.sender, uint216(currentReward));
        }
             sd.amountToStake += amount;
             sd.timeStaked = uint40(block.timestamp);
             //emit an event
             sd.staked = true;
            emit Staked(msg.sender, uint216(amount));
    }

    // Function to calaculate interate rate after a specific amount of days
    function getInterest(address user) internal view returns(uint216 interest){
        Stakedata memory sd = _stakeData[user];
        //require(sd.amountToStake > 0, "You have no token");
        if(sd.amountToStake > 0){
            uint216 currentAmount = uint216(sd.amountToStake);
            uint40 duration = uint40(block.timestamp) - sd.timeStaked;
            interest = uint216(delta * duration * currentAmount);
            interest/= uint216(factor);
        }
    }

        // With this function users can withdraw staked amount in batches
        function withdraw (uint256 amount) external {
            Stakedata storage sd = _stakeData[msg.sender];
            require(sd.staked == true);
            require( sd.amountToStake >= amount, "No sufficient token");
            uint216 amountToSend = uint216(amount);
            uint256 withdrawTokens;
            amountToSend += getInterest(msg.sender);
            sd.amountToStake -= uint216(amount);
            sd.timeStaked = uint40(block.timestamp);
            if (sd.timeStaked < 90 days){
            withdrawTokens =  50;
        }
        else if(sd.timeStaked >= 90 days) {
            withdrawTokens = 100;
           
            IERC20(MVPWAIR).transfer(msg.sender, amountToSend);

            emit Withdrawn(msg.sender, amountToSend);
        }

        // Function to get a particular user staking information.
        //function getUserData(address user) public view returns(Stakedata memory sd){
           // sd = _stakeData[user];
        }
}

