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
        var announcesList : [Announce] = []
        var categoriesList : [Category] = []

        let dispatchGroup = DispatchGroup()
        
        self.delegate?.viewModelDidSendEvent(event: .displayLoader)
        
        dispatchGroup.enter()
        
        NetworkManager.shared.listing { announces in
            announcesList = announces
            dispatchGroup.leave()

        } failureCompletionBlock: { error in
            dispatchGroup.leave()

        }
        
        dispatchGroup.enter()

        NetworkManager.shared.categories { categories in
            categoriesList = categories
            dispatchGroup.leave()

        } failureCompletionBlock: { error in
            dispatchGroup.leave()

        }
        
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.associateCategories(categoriesList, with: announcesList) { announcesWithCategories in
                announcesList = announcesWithCategories
                
                self?.delegate?.viewModelDidSendEvent(event: .hideLoader)
                self?.delegate?.viewModelDidSendEvent(event: .reloadView(announces: announcesList, categories: categoriesList))
            }
        }
    }
    
    private func associateCategories(_ categories: [Category],
                                     with announcesList: [Announce],
                                     completion: @escaping ([Announce]) -> Void) {
        
        var announces = announcesList
        for index in announces.indices {
            announces[index].category = categories.first(where: {$0.id == announces[index].categoryId})
        }
        
        completion(announces)
    }

}
