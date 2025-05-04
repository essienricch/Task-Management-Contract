// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/todo.sol";

contract TaskManagementTest is Test {
    taskManagement public task;

    function setUp() public {
        task = new taskManagement();
    }

   function testAddTodo() public {
        string memory content = "Complete project";
        task.addTodo(content);

        (uint id, string memory storedContent, taskManagement.Status status) = task.todos(0);

        assertEq(id, 0);
        assertEq(storedContent, content);
        assertEq(uint(status), uint(taskManagement.Status.Pending));
    }

    function testUpdateStatus() public {
        task.addTodo("Write tests");

        task.updateStatus(0, taskManagement.Status.Completed);
        (, , taskManagement.Status status) = task.todos(0);

        assertEq(uint(status), uint(taskManagement.Status.Completed));
    }

    function testGetTodo() public {
        string memory taskDesc = "Learn Foundry";
        task.addTodo(taskDesc);

        taskManagement.Todo memory todo = task.getTodo(0);

        assertEq(todo.id, 0);
        assertEq(todo.content, taskDesc);
        assertEq(uint(todo.status), uint(taskManagement.Status.Pending));
    }

    function testTodoIdsArray() public {
        task.addTodo("Task 1");
        task.addTodo("Task 2");

        assertEq(task.todoIds(0), 0);
        assertEq(task.todoIds(1), 1);
    }

    function testRevertOnInvalidUpdate() public {
        vm.expectRevert("Invalid Id");
        task.updateStatus(5, taskManagement.Status.Completed);
    }

    function testRevertOnInvalidGetTodo() public {
        vm.expectRevert("Invalid Id");
        task.getTodo(10);
    }
}