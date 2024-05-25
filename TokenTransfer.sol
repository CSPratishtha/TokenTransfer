// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomToken {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) private balances;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    function mint(uint256 amount) public onlyOwner {
        totalSupply += amount;
        balances[owner] += amount;
        emit Mint(owner, amount);
        emit Transfer(address(0), owner, amount);
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Cannot transfer to the zero address");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function remainingBalance(address account) public view returns (uint256) {
        return balances[account];
    }
}
