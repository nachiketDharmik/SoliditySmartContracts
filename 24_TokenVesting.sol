// SPDX-License-Identifier: MIT
// wtf.academy
pragma solidity ^0.8.0;

//import "../31_ERC20/ERC20.sol";
pragma solidity ^0.8.4;


interface IERC20 {
   
    event Transfer(address indexed from, address indexed to, uint256 value);

    
    event Approval(address indexed owner, address indexed spender, uint256 value);

    
    function totalSupply() external view returns (uint256);

   
    function balanceOf(address account) external view returns (uint256);

   
    function transfer(address to, uint256 amount) external returns (bool);

  
    function allowance(address owner, address spender) external view returns (uint256);

 
    function approve(address spender, uint256 amount) external returns (bool);

    
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract TokenVesting {
    
    event ERC20Released(address indexed token, uint256 amount); 

  
    mapping(address => uint256) public erc20Released; 
    uint256 public immutable start; 
    uint256 public immutable duration; 
address public immutable beneficiary; 
   
     
    constructor(
        address beneficiaryAddress,
        uint256 durationSeconds
    ) {
        require(beneficiaryAddress != address(0), "VestingWallet: beneficiary is zero address");
        beneficiary = beneficiaryAddress;
        start = block.timestamp;
        duration = durationSeconds;
    }

    function release(address token) public {
        
        uint256 releasable = vestedAmount(token, uint256(block.timestamp)) - erc20Released[token];
         
        erc20Released[token] += releasable; 
        
        emit ERC20Released(token, releasable);
        //Token transfer
        IERC20(token).transfer(beneficiary, releasable);
    }

   
    function vestedAmount(address token, uint256 timestamp) public view returns (uint256) {
        
        uint256 totalAllocation = IERC20(token).balanceOf(address(this)) + erc20Released[token];
        
        if (timestamp < start) {
            return 0;
        } else if (timestamp > start + duration) {
            return totalAllocation;
        } else {
            return (totalAllocation * (timestamp - start)) / duration;
        }
    }
}