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
    
    private var interactor: AnnouncesInteractor
    
    private(set) var announcesList: [Announce] = []

    private(set) var categoriesList: [Category] = []
    
    private(set) var error: Error = NetworkErrors.unknown
    
    //MARK: methods
    
    /**
            loading the announce list from interactor
     */
    
    init(interactor: AnnouncesInteractor = AnnouncesInteractor()) {
        self.interactor = interactor
    }
    
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

    func filterAnnouncesList(with categoryId: Int?) {
        if let categoryId = categoryId {
            self.announcesList = self.interactor.announcesList.filter({$0.categoryId == categoryId})
            self.delegate?.viewModelDidSendEvent(event: .reloadView)
            
        } else {
            Utils.log(log: "CategoryId is Null")
            
        }
       
    }
}
