//
//  UndoAction.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct UndoAction: View {
    let forTask: FetchedResults<Task>.Element
    
    var body: some View {
        Button(role: .cancel) {
            withAnimation {
                forTask.isComplete.toggle()
                PersistenceController.shared.save()
            }
        } label: {
            Text("Undo")
        }.accessibilityIdentifier(UTViewIDStrings.undoSwipeAction)
    }
}

struct UndoAction_Previews: PreviewProvider {
    static var previews: some View {
        UndoAction(forTask: Task())
    }
}
