//
//  AnnouncesViewModel.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import Foundation

class AnnouncesViewModel {
    
    weak var delegate: AnnouncesViewModelProtocol?
    
    //MARK:
    
    func loadAnnouncesList() {
        
        self.delegate?.viewModelDidSendEvent(event: .displayLoader)
        
        NetworkManager.shared.listing { [weak self ] announces in
            
            self?.delegate?.viewModelDidSendEvent(event: .hideLoader)
            self?.delegate?.viewModelDidSendEvent(event: .reloadView(announces))

        } failureCompletionBlock: { [weak self ] error in
            
            self?.delegate?.viewModelDidSendEvent(event: .hideLoader)
            self?.delegate?.viewModelDidSendEvent(event: .error(error))
            
        }
    }
}
