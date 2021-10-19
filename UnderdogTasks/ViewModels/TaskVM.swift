//
//  TaskVM.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import CoreData
import SwiftUI

final class TaskVM: ObservableObject {
    @Published var title        = ""
    @Published var notes        = ""
    @Published var date         = Date()
    @Published var isComplete   = false
    @Published var isBacklogged = false
    
    @Published var isAdding     = false
    @Published var isEditing    = false
    
    @Published var taskToUpdate: Task!
    
    let emptyToDoTitle = "To do:\nCreate New Tasks for Today!\nHit the Green Pencil to Get Started."
    let tasksToDoTitle = "To do:"
    
    let emptyDoneTitle = "Done:\nFinished Tasks Belong Here.\nSwipe Left on a Task to View More Options!"
    let tasksDoneTitle = "Done:"
    
    var textFieldPH: String {
        isAdding ? "Enter Task Here..." : taskToUpdate?.title ?? "Editing task..."
    }
    
    var taskSheetTitle: String {
        isAdding ? "Add to\nToday's List" : "Edit\nThis Task"
    }
    
    func addTask(context: NSManagedObjectContext) {
        let newTask = Task(context: context)
        newTask.title      = title
        newTask.notes      = notes
        newTask.date       = date
        newTask.isComplete = isComplete
        PersistenceController.shared.save()
        print(newTask.date!.formatted(date: .numeric, time: .shortened))
        isAdding           = false
        title              = ""
        notes              = ""
        isComplete         = false
        isBacklogged       = false
    }
    
    func updateTask() {
        taskToUpdate.title      = title
        taskToUpdate.notes      = notes
        taskToUpdate.date       = date
        taskToUpdate.isComplete = isComplete
        PersistenceController.shared.save()
        isEditing               = false
        taskToUpdate            = nil
        title                   = ""
        notes                   = ""
        isComplete              = false
        isBacklogged            = false
    }
    
    func backlogTask(task: FetchedResults<Task>.Element) {
        task.isBacklogged = true
        PersistenceController.shared.save()
    }
    
    //MARK: - Backlog Configurations
    @Published var backloggedTask: Task!

    var backlogs: [Task] = []
    private lazy var backlogFetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(format: "isBacklogged == true")
        return request
    }()
    
    func fetchBackloggedTasks() {
        let backloggedTasks = (try? PersistenceController.shared.container.viewContext.fetch(backlogFetchRequest)) ?? []
        backlogs = backloggedTasks
    }
}
