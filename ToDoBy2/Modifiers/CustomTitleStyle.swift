//
//  CustomTitleStyle.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/27/23.
//

import SwiftUI

struct CustomTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(.largeTitle, design: .rounded).weight(.bold))
    }
}

extension View {
    func customTitleStyle() -> some View {
        modifier(CustomTitleStyle())
    }
}
