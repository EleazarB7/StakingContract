# StakeContract Solidity Project

This project includes a Solidity smart contract named Stake, which allows users to stake and withdraw tokens with interest calculations.

## Smart Contract Details

- **Name**: Stake Contract
- **SPDX-License-Identifier**: MIT
- **Dependencies**: OpenZeppelin's IERC20, Ownable

### Functions

- constructor(address _mvpwair)
- stake(uint216 amount) external
- getInterest(address user) internal view returns(uint216 interest)
- withdraw(uint256 amount) external
- getUserData(address user) public view returns(Stakedata memory sd)

### Events

- event Staked(address indexed user, uint216 amount);
- event Withdrawn(address indexed user, uint216 amount);
- event InterestCompounded(address indexed user, uint216 amount);
  
### Usage
- Deploy the Stake Contract, providing the address of the MVPWAIR token.
- Users can stake their tokens using the stake function, which emits a Staked event.
- The interest is automatically compounded when users stake additional tokens.
- Users can withdraw their staked tokens with interest using the withdraw function, which emits a Withdrawn event.
-The getUserData function allows retrieving staking information for a specific user.

### Note
- The contract automatically compounds interest when users stake additional tokens.
- Users can withdraw their staked tokens with interest based on the duration of staking.
- Staking is recorded in batches, and users can withdraw tokens in batches.
