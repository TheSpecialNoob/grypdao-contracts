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

// File contracts/interfaces/IStaking.sol

interface IStaking {
    function stake(uint256 _amount, address _recipient) external returns (bool);

    function unstake(uint256 _amount, address _recipient) external returns (bool);

    function claim(address _recipient) external;

    function index() external view returns (uint256);
}

// File contracts/StakingHelper.sol

contract StakingHelper {
    address public immutable staking;
    address public immutable WAGMI;

    constructor(address _staking, address _WAGMI) {
        require(_staking != address(0));
        staking = _staking;
        require(_WAGMI != address(0));
        WAGMI = _WAGMI;
    }

    function stake(uint256 _amount, address recipient) external {
        IERC20(WAGMI).transferFrom(msg.sender, address(this), _amount);
        IERC20(WAGMI).approve(staking, _amount);
        IStaking(staking).stake(_amount, recipient);
        IStaking(staking).claim(recipient);
    }
}
