//
//  DeleteAction.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct DeleteAction: View {
    let forTask: FetchedResults<Task>.Element
    
    var body: some View {
        Button(role: .destructive) {
            withAnimation {
                PersistenceController.shared.container.viewContext.delete(forTask)
                PersistenceController.shared.save()
            }
        } label: {
            Text("Delete")
        }.accessibilityIdentifier(UTViewIDStrings.deleteSwipeAction)
    }
}

struct DeleteAction_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAction(forTask: Task())
    }
}
