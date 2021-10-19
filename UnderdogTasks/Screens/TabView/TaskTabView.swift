//
//  TaskTabView.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct TaskTabView: View {
    var body: some View {
        TabView {
            TaskListView()
                .tabItem {
                    Image(systemName: "text.badge.plus")
                        .tint(.green)
                }
            
            BacklogConfigurationView()
                .tabItem {
                    Image(systemName: "text.append")
                        .tint(.green)
                }
        }
    }
}

struct TaskTabView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTabView()
    }
}
