//
//  SidebarIcon.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 3/30/23.
//

import SwiftUI

struct SidebarIcon: View {
    
    @Binding var isActive: Bool
    
    var rectangle: some View {
        Rectangle()
            .frame(height: 20)
            .cornerRadius(4)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let bound = min(geometry.size.width, geometry.size.height)
            let barWidth = bound
            let barHeight = bound * 0.2
            let space = bound * 0.15
            VStack(alignment: .center, spacing: space){
                
                Rectangle()
                    .frame(width: barWidth, height: barHeight)
                    .cornerRadius(5)
                    .rotationEffect(.degrees(isActive ? 45 : 0))
                    .offset(y: isActive ? (barHeight + space) : 0)
                
                Rectangle()
                    .frame(width: barWidth, height: barHeight)
                    .cornerRadius(5)
                    .scaleEffect(isActive ? 0 : 1)
                    .opacity(isActive ? 0 : 1)
                
                Rectangle()
                    .frame(width: barWidth, height: barHeight)
                    .cornerRadius(5)
                    .rotationEffect(.degrees(isActive ? -45 : 0))
                    .offset(y: isActive ? -(barHeight + space) : 0)
                
            }
            .animation(.interpolatingSpring(stiffness: 250, damping: 12), value: isActive)
        }
        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
   }
}


struct SidebarIconPreviewWrapper: View {
    
    @State private var isActive = false
    
    var body: some View {
        SidebarIcon(isActive: $isActive)
            .onTapGesture {
                isActive.toggle()
            }
    }
}

struct SidebarIcon_Previews: PreviewProvider {
    static var previews: some View {
        SidebarIconPreviewWrapper()
            .frame(width: 200, height: 200)
    }
}
