// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract taskManagement {

    event TodoAdded(uint id, string content);

    enum Status {
        Pending,
        InProgress,
        Completed
    }

    struct Todo {
        uint id;
        string content;
        Status status;
    }

    mapping (uint => Todo) public todos;
    uint [] public todoIds;

    modifier checkTodoLength(uint _id) {
        require(_id < todoIds.length, "Invalid Id");
        _;
    }

    function addTodo (string memory _content) external {
        uint id = todoIds.length;
        todos[id] = Todo(id,_content,Status.Pending);
        todoIds.push(id);
        emit TodoAdded(id, _content);
    }

    function updateStatus(uint _id, Status _status) external checkTodoLength(_id) {
        todos[_id].status = _status;
    }

    function getTodo(uint _id) external view checkTodoLength(_id) returns (Todo memory){
        return todos[_id];
    } 
}