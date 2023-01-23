//
//  TaskView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/15/23.
//

import SwiftUI

struct TaskView: View {
    
    @ObservedObject var vm: TaskViewModel
    
    var body: some View {
        VStack {
            Text(vm.title)
            TextField("Edit Title", text: vm.titleBinding)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(vm: TaskViewModel.sample)
    }
}
