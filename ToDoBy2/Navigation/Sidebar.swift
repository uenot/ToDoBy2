//
//  Sidebar.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 3/29/23.
//

import SwiftUI

struct Sidebar: View {
    
    @Binding var destination: Destination
    @Binding var displaySidebar: Bool
    
    func customNavLink(_ value: Destination, label: any View) -> some View {
        EmptyView()
    }
    
    var content: some View {
        VStack {
            Text("ToDoBy2")
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .onTapGesture {
                    destination = .mainTM
                    displaySidebar.toggle()
                }
            List {
                ForEach(Constants.destinations) { section in
                    Section {
                        ForEach(section) { dest in
                            Button(dest.description) {
                                destination = dest
                                displaySidebar.toggle()
                            }
                        }
                    }
                }
            }
        }
        .background()
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width * 0.75
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(.black.opacity(0.6))
                .opacity(displaySidebar ? 1 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    displaySidebar.toggle()
                }
                
                HStack(alignment: .top) {
                    content
                        .frame(width: width)
                        .offset(x: displaySidebar ? 0 : -width)
                    Spacer()
                        .ignoresSafeArea()
                }
            }
            .animation(.easeInOut(duration: 0.3), value: displaySidebar)
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(destination: .constant(.mainTM), displaySidebar: .constant(true))
    }
}
