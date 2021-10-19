//
//  CreateTaskButton.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct CreateTaskButton: View {
    @ObservedObject var viewModel: TaskVM
    
    var body: some View {
        Button {
            viewModel.isAdding = true
        } label: {
            Label {
                Text("New Task")
            } icon: {
                Image(systemName: "pencil.circle")
            }
        }
        .tint(.green)
        .accessibilityIdentifier(UTViewIDStrings.createTaskButton)
    }
}

struct CreateTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskButton(viewModel: TaskVM())
    }
}
