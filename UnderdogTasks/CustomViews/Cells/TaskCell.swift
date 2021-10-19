//
//  TaskCell.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct TaskCell: View {
    @ObservedObject var task: FetchedResults<Task>.Element
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(task.title ?? "N/A")
                    .foregroundColor(task.isComplete ? .red : .primary)
                    .font(.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .accessibilityLabel(task.title ?? "N/A")
                
                Text(task.notes ?? "N/A")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            
            Spacer()
            
            Text(task.date?.formatted(date: .numeric, time: .shortened) ?? Date().formatted(date: .numeric, time: .shortened))
                .font(.caption)
                .foregroundColor(.secondary)
            
        }.padding(16)
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: Task())
    }
}
