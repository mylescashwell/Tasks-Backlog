//
//  ContentView.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskVM()
    
    var body: some View {
        NavigationView {
            List {
                ToDoSection(viewModel: viewModel)
                DoneSection(viewModel: viewModel)
            }
            .navigationTitle("Today")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CreateTaskButton(viewModel: viewModel)
                }
            })
            .sheet(isPresented: viewModel.isAdding ? $viewModel.isAdding : $viewModel.isEditing) {
                NewTaskSheet(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
