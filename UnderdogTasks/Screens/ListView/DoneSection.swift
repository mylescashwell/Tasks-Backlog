//
//  DoneSection.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct DoneSection: View {
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)],
        predicate: NSPredicate(format: "isBacklogged == false AND isComplete == true")
    ) var tasks: FetchedResults<Task>
    @ObservedObject var viewModel: TaskVM
    
    var body: some View {
        Section(tasks.isEmpty ? viewModel.emptyDoneTitle : viewModel.tasksDoneTitle) {
            ForEach(tasks) { task in
                TaskCell(task: task)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        UndoAction(forTask: task)
                        DeleteAction(forTask: task)
                    }
            }
        }
    }
}

struct DoneSection_Previews: PreviewProvider {
    static var previews: some View {
        DoneSection(viewModel: TaskVM())
    }
}
