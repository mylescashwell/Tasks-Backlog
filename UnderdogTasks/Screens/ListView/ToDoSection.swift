//
//  ToDoSection.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct ToDoSection: View {
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)],
        predicate: NSPredicate(format: "isBacklogged == false AND isComplete == false")
    ) var tasks: FetchedResults<Task>
    @ObservedObject var viewModel: TaskVM
    
    var body: some View {
        Section(tasks.isEmpty ? viewModel.emptyToDoTitle : viewModel.tasksToDoTitle) {
            ForEach(tasks) { task in
                TaskCell(task: task)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        CompleteAction(forTask: task)
                        UpdateAction(viewModel: viewModel, forTask: task)
                        DeleteAction(forTask: task)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        BacklogAction(viewModel: viewModel, task: task)
                    }
            }
        }
    }
}

struct ToDoSection_Previews: PreviewProvider {
    static var previews: some View {
        ToDoSection(viewModel: TaskVM())
    }
}
