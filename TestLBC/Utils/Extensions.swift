//
//  Extensions.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import UIKit

//MARK: Date extension

extension Date {
    
    /**
            Contains the string date value
                with the " dd MMM yyyy à HH:mm " format
     */
    
    var stringDate: String {
        let formatter = DateFormatter.lbcDateFormatter
        formatter.dateFormat = "dd MMM yyyy \(NSLocalizedString("à", comment: "")) HH:mm "
        return formatter.string(from: self)
    }
}

//MARK: DateFormatter extension

extension DateFormatter {
    
    /**
            Contains our DateFormatter
            used by the Decoder and the stringDate property
     */
    
    static let lbcDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
}

//MARK: Double extension

/**
    Convert a Double value type to string Euro currency format
        Force the local identifier "fr_FR" to get the € symbol while testing on simulator
 */

extension Double {
    
    var euroFormat: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.locale = Locale(identifier: "fr_FR")
        return currencyFormatter.string(for: self) ?? ""
    }
    
}
