//
//  TaskView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm: TaskViewModel
    
    var body: some View {
        VStack {
            TextField("Edit Title", text: vm.titleBinding)
                .multilineTextAlignment(.center)
            Group {
                if (vm.isComplete) {
                    Text("Complete").foregroundColor(.green)
                } else {
                    Text("Incomplete").foregroundColor(.indigo)
                }
            }
            .padding()
            Button(vm.isComplete
                   ? "Mark as Incomplete"
                   : "Mark as Complete") {
                if (vm.isComplete) {
                    vm.send(.markIncomplete)
                } else {
                    vm.send(.markComplete)
                }
            }
            Button {
                dismiss()
                vm.send(.deleteSelf)
            } label: {
                Text("Delete")
                    .foregroundColor(.red)
            }
            .padding()
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(vm: TaskViewModel.sample)
    }
}
