//
//  ContentView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var taskManagerVM = TaskManagerViewModel.sample
    
    var body: some View {
        TaskManagerView(vm: taskManagerVM)
            .onAppear {
                Task {
                    // await taskManagerVM.load()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
