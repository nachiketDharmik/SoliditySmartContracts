// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
    contract Overload {
    function a() public pure returns(string memory){
        return("Nothing");
    }

    function a(string memory text) external payable returns(string memory text1){
        return(text);
    }

    function f(uint8 _in) public pure returns (uint8 out) {
        out = _in;
    }

    function f(uint256 _in) public pure returns (uint256 out) {
        out = _in;
    }
}