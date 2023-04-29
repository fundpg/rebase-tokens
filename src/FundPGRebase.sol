// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract FundPGRebase is ERC20, Ownable{
    IERC20 public token;

    constructor(address _token) ERC20("FundPGRebase", "FPG") {
        token = IERC20(_token);
    }

    function getExcessFunds() external view returns (uint256) {
        return token.balanceOf(address(this)) - totalSupply();
    }

    function stake(uint256 _amount) external {
        token.transferFrom(msg.sender, address(this), _amount);
        _mint(msg.sender, _amount);
    }

    function unstake(uint256 _amount) external {
        _burn(msg.sender, _amount);
        token.transfer(msg.sender, _amount);
    }

    function withdraw(address _dstAddress, uint256 _amount) external onlyOwner {
        token.transfer(_dstAddress, _amount);
    }
}
