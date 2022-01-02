// Sources flattened with hardhat v2.6.8 https://hardhat.org

// File contracts/ERC20/IERC20.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

interface IERC20 {
    function decimals() external view returns (uint8);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function totalSupply() external view returns (uint256);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File contracts/StakingWarmup.sol

contract StakingWarmup {
    address public immutable staking;
    address public immutable sGRYP;

    constructor(address _staking, address _sGRYP) {
        require(_staking != address(0));
        staking = _staking;
        require(_sGRYP != address(0));
        sGRYP = _sGRYP;
    }

    function retrieve(address _staker, uint256 _amount) external {
        require(msg.sender == staking);
        IERC20(sGRYP).transfer(_staker, _amount);
    }
}
