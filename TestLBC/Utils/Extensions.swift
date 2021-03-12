//
//  Extensions.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import UIKit


extension String {
    var stringDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.string(from: dateFormatter.date(from: self) ?? Date())
    }
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: self) ?? Date()
    }
}

extension Double {
    var euroFormat: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.locale = Locale(identifier: "fr_FR")
        return currencyFormatter.string(for: self) ?? ""
    }
}
