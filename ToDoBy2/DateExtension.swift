//
//  DateExtension.swift
//  ToDoBy2
//
//  Created by Toby Ueno on 2/28/23.
//

import Foundation

extension Date {
    // define all operations with day-level granularity
    static func + (left: Date, right: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: right, to: left)!
    }
    
    static func - (left: Date, right: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -right, to: left)!
    }
    
    static func += (left: inout Date, right: Int) {
        left = left + right
    }
    
    static func -= (left: inout Date, right: Int) {
        left = left - right
    }
    
    static func == (left: Date, right: Date) -> Bool {
        Calendar.current.compare(left, to: right, toGranularity: .day) == .orderedSame
    }
    
    static func < (lhs: Date, rhs: Date) -> Bool {
        Calendar.current.compare(lhs, to: rhs, toGranularity: .day) == .orderedAscending
    }
    
    static func > (left: Date, right: Date) -> Bool {
        Calendar.current.compare(left, to: right, toGranularity: .day) == .orderedDescending
    }
    
    static func <= (left: Date, right: Date) -> Bool {
        Calendar.current.compare(left, to: right, toGranularity: .day) != .orderedDescending
    }
    
    static func >= (left: Date, right: Date) -> Bool {
        Calendar.current.compare(left, to: right, toGranularity: .day) != .orderedAscending
    }
}
