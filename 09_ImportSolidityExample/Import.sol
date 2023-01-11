// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import '../ImportSolidityExample/Yeye.sol';

//Importing Strings library from  10_Library
import {Strings} from '../10_Library.sol';

import {Yeye} from './Yeye.sol';

import '@openzeppelin/contracts/utils/Address.sol';

import '@openzeppelin/contracts/access/Ownable.sol';

contract Import  {
    
    using Address for address;

    
  
    Yeye yeye = new Yeye();

   
    function test() external{
        yeye.hip();
       Strings.toHexString(10);
    }
}