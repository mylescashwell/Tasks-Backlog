//
//  BacklogAction.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct BacklogAction: View {
    @ObservedObject var viewModel: TaskVM
    @ObservedObject var task: FetchedResults<Task>.Element
    var body: some View {
        Button(role: .cancel) {
            withAnimation {
                viewModel.backloggedTask = task
                viewModel.backlogTask(task: task)
            }
        } label: {
            Text("Backlog")
        }
        .tint(.black)
//        .accessibilityIdentifier(UTViewIDStrings.backlogSwipeAction)
    }
}

struct BacklogAction_Previews: PreviewProvider {
    static var previews: some View {
        BacklogAction(viewModel: TaskVM(), task: Task())
    }
}
