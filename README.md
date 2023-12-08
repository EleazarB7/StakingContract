# StakeContract Solidity Project

This project includes a Solidity smart contract named StakeContract, which allows users to stake and withdraw tokens with interest calculations.

## Smart Contract Details

- **Name**: StakeContract
- **SPDX-License-Identifier**: MIT
- **Dependencies**: OpenZeppelin's IERC20, Ownable

### Functions

```solidity
constructor(address _mvpwair)
stake(uint216 amount) external
getInterest(address user) internal view returns(uint216 interest)
withdraw(uint256 amount) external
getUserData(address user) public view returns(Stakedata memory sd)
