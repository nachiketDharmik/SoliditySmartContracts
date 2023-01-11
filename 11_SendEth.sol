// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


// transfer: 2300 gas, revert
// send: 2300 gas, return bool
// call: all gas, return (bool, data)

error SendFailed(); 
error CallFailed(); 

contract SendETH {
    
    constructor() payable{}
    
   
   
    function transferETH(address payable _to, uint256 amount) external payable{
        _to.transfer(amount);
    }

    
    function sendETH(address payable _to, uint256 amount) external payable{
        
        bool success = _to.send(amount);
        if(!success){
            revert SendFailed();
        }
    }

   
    function callETH(address payable _to, uint256 amount) external payable{
        
        (bool success,) = _to.call{value: amount}("");
        if(!success){
            revert CallFailed();
        }
    }
}

contract ReceiveETH is SendETH {
    
    event Log(uint amount, uint gas);

 uint256 a = 100 ;
 uint public b ;
    receive() external payable{
        emit Log(msg.value, gasleft());
        b = a;
    }
    
    
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
} 