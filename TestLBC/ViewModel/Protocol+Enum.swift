//
//  Protocol+Enum.swift
//  TestLBC
//
//  Created by Aymen on 11/03/2021.
//

import Foundation

enum AnnouncesViewModelEvent {
    case reloadView(_ annouces: [Announce] )
    case error(_ error: Error)
    case displayLoader
    case hideLoader

}

protocol AnnouncesViewModelProtocol: AnyObject {
    func viewModelDidSendEvent(event: AnnouncesViewModelEvent)
}