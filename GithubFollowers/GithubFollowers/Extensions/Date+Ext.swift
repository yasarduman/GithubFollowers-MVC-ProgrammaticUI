//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 5.10.2023.
//

import Foundation

extension Date {
    
//   func convertToMonthYearFormat() -> String {
//       let dateFormatter           = DateFormatter()
//       dateFormatter.dateFormat    = "MMM yyyy"
//       return dateFormatter.string(from: self)
//   }
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
