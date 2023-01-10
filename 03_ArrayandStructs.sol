// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract ArrayTypes {

    // Static Array
    uint[8] public array1;
    bytes1[5]  public array2;
    address[100] public  array3;

    // Dynamic Array
    uint[] public array4;
    bytes1[] public array5;
    address[] public array6;
    bytes public array7;

    uint[] public array8 = new uint[](5);
    bytes  public array9 = new bytes(9);
    
    function initArray() external pure returns(uint[] memory){
        uint[] memory x = new uint[](3);
        x[0] = 1;
        x[1] = 3;
        x[2] = 4;
        return(x);
    }  
    function arrayPush() public returns(uint[] memory){
        uint[2] memory a = [uint(1),2];
        array4 = a;
        array4.push(3);
        return array4;
    }
}

pragma solidity ^0.8.4;
contract StructTypes is ArrayTypes {
    
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student public student; 
    mapping(uint => Student) public structMap ;
    
    function initStudent1() external{
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }

     
    function initStudent2() external{
        student.id = 1;
        student.score = 80;
    }

    function initStructMap() external {
        structMap[0] = Student(1,11);
    }

   function updateStructMap() external {

       structMap[0].id = 123;
       structMap[1].score = 111122223333;
   }

}

pragma solidity ^0.8.4;
contract EnumTypes is StructTypes {
    
    enum ActionSet { Buy, Hold, Sell }
   
    ActionSet action = ActionSet.Buy;

  
    function enumToUint() external view returns(uint){
        return uint(action);
    }
}