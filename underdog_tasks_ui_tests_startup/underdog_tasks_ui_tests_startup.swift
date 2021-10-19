//
//  underdog_tasks_ui_tests_startup.swift
//  underdog_tasks_ui_tests_startup
//
//  Created by Myles Cashwell on 10/12/21.
//

import XCTest
import SwiftUI

class underdog_tasks_ui_tests_startup: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func test_adding_task_to_list() {
        let createTaskButton = app.buttons[UITestingStrings.createTaskButton]
        createTaskButton.tap()
        
        let taskTitleTextField = app.textFields[UITestingStrings.titleTextField]
        taskTitleTextField.tap()
        taskTitleTextField.typeText("UI Testing \n")
        
        let addTaskButton = app.buttons[UITestingStrings.addTaskButton]
        addTaskButton.tap()
        
        let taskCount = app.tables.children(matching: .cell).count
        
        XCTAssertTrue(taskCount >= 1)
    }
}

class underdog_ui_tests_completing_action: underdog_tasks_ui_tests_startup {
    func test_completing_action() {
        let cell = app.tables.children(matching: .cell).firstMatch
        cell.swipeLeft()
        
        let completeSwipeAction = cell.buttons[UITestingStrings.completeSwipeAction]
        completeSwipeAction.tap()
        
        let doneCell = app.tables.children(matching: .cell).firstMatch
        XCTAssertNotNil(doneCell)
    }
}

class underdog_ui_tests_undo_action: underdog_ui_tests_completing_action {
    func test_undo_action() {
        let doneCell = app.tables.children(matching: .cell).firstMatch
        doneCell.swipeLeft()
        
        let undoSwipeAction = doneCell.buttons[UITestingStrings.undoSwipeAction]
        undoSwipeAction.tap()
        
        let toDoCell = app.tables.children(matching: .cell).firstMatch
        XCTAssertTrue(toDoCell.exists)
    }
}

class underdog_ui_tests_deleting_action: underdog_tasks_ui_tests_startup {
    func test_deleting_action() {
        let cellTotal = app.tables.children(matching: .cell).count
        let cell      = app.tables.children(matching: .cell).firstMatch
        cell.swipeLeft()
        
        let deleteAction = cell.buttons[UITestingStrings.deleteSwipeAction]
        deleteAction.tap()
        
        if cellTotal == 1 {
            XCTAssertNil(cell)
        } else {
            XCTAssertTrue(cellTotal >= 1)
        }
    }
}

class underdog_ui_tests_updating_action: underdog_tasks_ui_tests_startup {
    func test_updating_action() {
        let cell = app.tables.children(matching: .cell).firstMatch
        cell.swipeLeft()
        
        let updateAction = cell.buttons[UITestingStrings.updateSwipeAction]
        updateAction.tap()
        
        let taskTitleTextField = app.textFields.firstMatch
        taskTitleTextField.tap()
        taskTitleTextField.typeText("Edited Title from Testing \n")
        
        let editTaskButton = app.buttons[UITestingStrings.addTaskButton]
        editTaskButton.tap()
        
        let editedCell = app.tables.children(matching: .cell).firstMatch
        
        XCTAssertEqual(editedCell.label, "Edited Title from Testing" + " , " + Date().formatted(date: .numeric, time: .shortened))
    }
}
