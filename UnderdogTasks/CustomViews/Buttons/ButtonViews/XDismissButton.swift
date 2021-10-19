//
//  XDismissButton.swift
//  UnderdogTasks
//
//  Created by Myles Cashwell on 10/11/21.
//

import SwiftUI

struct XDismissButton: View {
    @ObservedObject var viewModel: TaskVM
    
    var body: some View {
        Button {
            viewModel.isAdding  = false
            viewModel.isEditing = false
        } label: {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .opacity(0.5)
                
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .font(.caption)
            }.padding()
        }
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton(viewModel: TaskVM())
    }
}
