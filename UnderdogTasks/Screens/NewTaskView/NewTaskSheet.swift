//
//  NewTaskSheet.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct NewTaskSheet: View {
    @ObservedObject var viewModel: TaskVM
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    XDismissButton(viewModel: viewModel)
                }
            
            VStack {
                TitleStack(viewModel: viewModel)
                
                Divider()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                
                NotesStack(viewModel: viewModel)
                
                AddTaskButton(viewModel: viewModel)
                    .disabled(viewModel.title.isEmpty)
            }
        }
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskSheet(viewModel: TaskVM())
    }
}

struct TitleStack: View {
    @ObservedObject var viewModel: TaskVM
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(viewModel.taskSheetTitle)
                    .font(.largeTitle)
                    .bold()
                    .minimumScaleFactor(0.5)
                    .padding(.top, 24)
                
                Spacer()
            }.padding(.horizontal)
            
            TextField(viewModel.textFieldPH, text: $viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .accessibilityIdentifier(UTViewIDStrings.titleTextField)
        }
    }
}

struct NotesStack: View {
    @ObservedObject var viewModel: TaskVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Enter any notes below:")
                .foregroundColor(.secondary)
                .font(.caption)
                .padding(.leading)
            
            TextEditor(text: $viewModel.notes)
                .frame(maxWidth: .infinity, maxHeight: 256)
                .cornerRadius(16)
                .padding(.horizontal, 16)
        }
    }
}
