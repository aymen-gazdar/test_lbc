//
//  AnnouncesViewModel.swift
//  TestLBC
//
//  Created by Aymen on 08/03/2021.
//

import Foundation

class AnnouncesViewModel {
    
    //MARK: var

    weak var delegate: AnnouncesViewModelProtocol?
    
    private var interactor: AnnouncesInteractor = AnnouncesInteractor()
    
    private(set) var announcesList: [Announce] = []

    private(set) var categoriesList: [Category] = []
    
    private(set) var error: Error = NetworkErrors.unknown
    
    //MARK: methods
    
    /**
            loading the announce list from interactor
     */
    
    func loadAnnouncesList() {
        self.interactor.fetchAnnounces(successCompletionBlock: { [weak self] announcesList, categoriesList  in
            guard let strongSelf = self else { return }
            
            strongSelf.announcesList = announcesList
            strongSelf.categoriesList = categoriesList

            strongSelf.delegate?.viewModelDidSendEvent(event: .reloadView)
            
        }, failureCompletionBlock: { [weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.error = error
            strongSelf.delegate?.viewModelDidSendEvent(event: .error)

        })
    }

}
