//
//  AddTaskButton.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct AddTaskButton: View {
    @ObservedObject var viewModel: TaskVM
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button {
            if viewModel.taskToUpdate == nil {
                viewModel.addTask(context: moc)
            } else {
                viewModel.updateTask()
            }
        } label: {
            Text(viewModel.isEditing ? "Update Task" : "Add Task")
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, maxHeight: 56)
                .background(Color.brandPrimary)
                .cornerRadius(16)
                .padding(.horizontal, 16)
        }.accessibilityIdentifier(UTViewIDStrings.addTaskButton)
    }
}

struct AddTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButton(viewModel: TaskVM())
    }
}
