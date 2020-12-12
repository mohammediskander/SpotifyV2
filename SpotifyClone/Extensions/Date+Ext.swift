//
//  Date+Ext.swift
//  Todoiest
//
//  Created by Mohammed Iskandar on 08/12/2020.
//

import Foundation

extension Date {
    func fromNow() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
