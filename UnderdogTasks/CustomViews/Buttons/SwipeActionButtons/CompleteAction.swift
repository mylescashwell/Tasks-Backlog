//
//  CompleteAction.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct CompleteAction: View {
    let forTask: FetchedResults<Task>.Element
    
    var body: some View {
        Button {
            withAnimation {
                forTask.isComplete.toggle()
                PersistenceController.shared.save()
            }
        } label: {
            Text("Complete")
        }
        .tint(.green)
        .accessibilityIdentifier(UTViewIDStrings.completeSwipeAction)
    }
}

struct CompleteAction_Previews: PreviewProvider {
    static var previews: some View {
        CompleteAction(forTask: Task())
    }
}
