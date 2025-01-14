// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol"; // Added ReentrancyGuard

contract xDOJ is ERC20, Ownable, ReentrancyGuard { // Inherits from ReentrancyGuard
    using SafeERC20 for IERC20;

    constructor() ERC20("xDOJ", "xDOJ") Ownable(msg.sender) {
        // Mint a total supply of 7 billion tokens to the deployer's address
        _mint(msg.sender, 7_000_000_000 * 10 ** decimals());
    }

    /**
     * @dev Overrides decimals to ensure compatibility with ERC20 token standards.
     * xDOJ uses 18 decimal places.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev Allows the owner to recover accidentally sent ERC20 tokens.
     * Includes nonReentrant to prevent reentrancy attacks.
     */
    function recoverERC20(address tokenAddress, uint256 tokenAmount) external onlyOwner nonReentrant {
        require(tokenAddress != address(this), "xDOJ: Cannot recover xDOJ tokens");
        IERC20(tokenAddress).safeTransfer(owner(), tokenAmount);
    }
}
