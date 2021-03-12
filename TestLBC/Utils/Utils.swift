//
//  Utils.swift
//  TestLBC
//
//  Created by Aymen on 10/03/2021.
//

import Foundation

class Utils {
    
    //MARK: Main Thread Checker closure

    static func runOnMainThread(_ block: @escaping()-> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
    
    //MARK: Logger

    static func log(log: String = "") {
        #if DEBUG
            print(log)
        #endif
    }
}
