//
//  ArrayExtension.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 4/25/23.
//

import Foundation

// added to iterate over [[Destination]] in ForEach
extension Array: Identifiable where Element: Hashable {
    public var id: Self { self }
}
