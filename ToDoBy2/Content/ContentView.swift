//
//  ContentView.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 1/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = ContentViewModel.sample
    @Environment(\.scenePhase) private var scenePhase
    
    // maybe move to model if we want this to persist
    @State private var homeViewType: Destination = .mainTM
    @ViewBuilder
    private var homeView: some View {
        switch homeViewType {
        case .mainTM:
            TaskManagerView(vm: vm.createTaskManagerViewModel())
        case .credits:
            Credits()
        default:
            Text("unimplemented")
        }
    }
    
    @State private var displaySidebar = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                homeView
                    .animation(.easeInOut(duration: 0.4), value: homeViewType)
                    .transition(.asymmetric(insertion: .slide, removal: .opacity))
                Sidebar(destination: $homeViewType, displaySidebar: $displaySidebar)
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            displaySidebar.toggle()
                        } label: {
                            SidebarIcon(isActive: $displaySidebar)
                                .frame(width: 16, height: 16)
                        }
                    }
                }
        }
        .onChange(of: scenePhase) { phase in
            if (phase == .inactive) {
                Task {
                    await vm.save()
                }
            }
        }
        .onAppear {
            Task {
                await vm.load()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
