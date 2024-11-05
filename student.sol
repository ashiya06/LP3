// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Student_Management {

    struct Student {
        int stud_id;
        string stud_Name;
        string department;
    }

    Student[] Students;

    // Function to add a new student
    function add_student_detail(int stud_id, string memory stud_Name, string memory department) public {
        Student memory stud_Data = Student(stud_id, stud_Name, department);
        Students.push(stud_Data);
    }

    // Function to get student details by student ID
    function getStudent_detail(int stud_id) public view returns(string memory, string memory) {
        for (uint i = 0; i < Students.length; i++) {
            Student memory stud = Students[i];
            if (stud.stud_id == stud_id) {
                return (stud.stud_Name, stud.department);
            }
        }
        return ("Not Found", "Not Found");
    }

    // Additional function to get the number of students
    function get_student_count() public view returns (uint) {
        return Students.length;
    }

    // Additional function to get the total gas used for adding students
    function estimate_gas_for_add(int stud_id, string memory stud_Name, string memory department) public returns (uint256) {
        uint256 startGas = gasleft();
        
        // Call the add_student_detail function to measure gas used
        add_student_detail(stud_id, stud_Name, department);
        
        uint256 gasUsed = startGas - gasleft();
        return gasUsed;
    }

    // Receive function to accept Ether with no data
    receive() external payable {
        // Custom logic, if any, for receiving Ether
    }

    // Fallback function for non-existent function calls or Ether transfers with data
    fallback() external payable {
        revert("Function not found or contract does not accept Ether with data.");
    }
}

