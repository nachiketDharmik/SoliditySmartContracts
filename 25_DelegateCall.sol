SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
* All calls of the @dev Proxy contract are delegated to another contract via the `delegatecall` opcode.  The latter is called a logic contract (Implementation).
 *
* The return value of the delegate call will be returned directly to the caller of the Proxy
 */
contract Proxy {
    address   public implementation; // Logical contract address.  The state variable type in the same position of the implementation contract must be the same as that of the Proxy contract, otherwise an error will be reported.

    /**
     * @dev Initialize the logical contract address
     */
    constructor(address implementation_){
        implementation = implementation_;
    }

    /**
     * @dev Callback function, call the `_delegate()` function to delegate the call of this contract to the `implementation` contract
     */
    fallback() external payable {
        _delegate();
    }

    /**
     * @dev delegates the call to the logic contract to run
     */
    function _delegate() internal {
        assembly {
             Copy msg.data. We take full control of memory in this inline assembly
             block because it will not return to Solidity code. We overwrite the
             Read the storage whose location is 0, which is the implementation address.
            let _implementation := sload(0)

            calldatacopy(0, 0, calldatasize())

             Use delegatecall to call the implementation contract
             The parameters of the delegatecall opcode are: gas, target contract address, input mem start position, input mem length, output area mem start position, output area mem length
             output area start position and length position, so set to 0
             delegatecall successfully returns 1, fails and returns 0
            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

             Copy returndata whose starting position is 0 and whose length is returndatasize() to mem position 0
            returndatacopy(0, 0, returndatasize())

            switch result
             If the delegate call fails, revert
            case 0 {
                revert(0, returndatasize())
            }
             If the delegate call succeeds, return the data with the starting position of mem being 0 and the length of returndatasize() (the format is bytes)
            default {
                return(0, returndatasize())
            }
        }
    }
}

/**
* @dev logic contract, execute the delegated call
 */
contract Logic {
    address   public implementation;  Be consistent with Proxy to prevent slot conflicts
    uint public x = 99; 
    event CallSuccess();

     This function releases LogicCalled and returns a uint.
     function selector: 0xd09de08a
    function increment() external returns(uint) {
        emit CallSuccess();
        return x + 1;
    }
}

/**
* @dev Caller contract, call the proxy contract, and get the execution result
*/
contract Caller{
    address  public proxy;  Agent contract address

    constructor(address proxy_){
        proxy = proxy_;
    }

    Call the increase() function through the proxy contract
    function increase() external returns(uint) {
 ( , bytes  memory  data) = proxy. call(abi.encodeWithSignature("increment()"));
        return abi.decode(data,(uint));
    }
}