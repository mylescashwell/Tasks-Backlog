//
//  UpdateAction.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct UpdateAction: View {
    @ObservedObject var viewModel: TaskVM
    let forTask: FetchedResults<Task>.Element
    
    var body: some View {
        Button(role: .cancel) {
            viewModel.isEditing    = true
            viewModel.taskToUpdate = forTask
        } label: {
            Text("Update")
        }
        .tint(.brandPrimary)
        .accessibilityIdentifier(UTViewIDStrings.updateSwipeAction)
    }
}

struct UpdateAction_Previews: PreviewProvider {
    static var previews: some View {
        UpdateAction(viewModel: TaskVM(), forTask: Task())
    }
}
