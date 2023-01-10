// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract A {
    event Log(string msg);

    
    function hip() public virtual{
        emit Log("A");
    }

    function pop() public virtual{
        emit Log("A");
    }

    function yeye() public virtual {
        emit Log("A");
    }
}

contract B is A{
   
    function hip() public virtual override{
        emit Log("B");
    }

    function pop() public virtual override{
        emit Log("B");
    }

    function baba() public virtual{
        emit Log("B");
    }
}

contract C is A, B {
   
    function hip() public virtual override(A,B){
        emit Log("C");
    }

    function pop() public virtual override(A, B) {
        emit Log("C");
    }

    function callParent() public{
        A.pop();
    }

    function callParentSuper() public{
        super.pop();
    }
}

