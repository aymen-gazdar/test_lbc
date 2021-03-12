//
//  Protocol+Enum.swift
//  TestLBC
//
//  Created by Aymen on 11/03/2021.
//

import Foundation

enum AnnouncesViewModelEvent {
    case reloadView
    case error
    case displayLoader
    case hideLoader

}

protocol AnnouncesViewModelProtocol: AnyObject {
    func viewModelDidSendEvent(event: AnnouncesViewModelEvent)
}
