//
//  Extensions.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import UIKit

/**
    AutoLayout Property Wrapper :
        allowing to do not constantly writing
        view.translatesAutoresizingMaskIntoConstraints = false
 */

@propertyWrapper
public struct UseAutoLayout<T: UIView> {
    public var wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
