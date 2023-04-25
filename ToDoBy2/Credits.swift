//
//  Credits.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/25/23.
//

import SwiftUI

struct Credits: View {
    var body: some View {
        VStack {
            // abstract these into a constants file
            Text("ToDoBy2")
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
            Text("Developed by Toby Ueno")
                .font(.system(.subheadline, design: .rounded).italic())
                .padding(.bottom)
            Text("This app was developed over lorem ipsum dolor sit amet etc etc etc")
                .padding(10)
            Text("again we have another chunk of text lorem ipsum lorem ipsum dolor sit amet quo quoque etc")
                .padding(10)
        }
    }
}

struct Credits_Previews: PreviewProvider {
    static var previews: some View {
        Credits()
    }
}
