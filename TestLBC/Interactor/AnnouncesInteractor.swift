//
//  AnnouncesInteractor.swift
//  TestLBC
//
//  Created by Aymen on 12/03/2021.
//

import Foundation

/**
    This interactor has the role of a business Layer
        it recuperate and treat the data from the DataSource (NetworkLayer in our case),
        and pass it to the ViewModel
 */

class AnnouncesInteractor {
    
    //MARK: var let

    var announcesList: [Announce]

    var categoriesList: [Category] = []

    private(set) var networkManager: NetworkManager
    
    //MARK: init
    
    init(announces: [Announce] = [], networkManager: NetworkManager = NetworkManager()) {
        self.announcesList = announces
        self.networkManager = networkManager
    }
    
    //MARK: methods

    /**
            recuperate announces and categories from NetworkLayer
     */
    
    func fetchAnnounces(successCompletionBlock: @escaping ([Announce], [Category]) -> Void,
                        failureCompletionBlock: @escaping (Error) -> Void) {
        
        let dispatchGroup = DispatchGroup()
            
        dispatchGroup.enter()
        networkManager.listing { [weak self] announces in
            guard let strongSelf = self else { return }
            strongSelf.announcesList = announces
            dispatchGroup.leave()

        } failureCompletionBlock: { error in
            failureCompletionBlock(error)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkManager.categories { [weak self] categories in
            guard let strongSelf = self else { return }
            strongSelf.categoriesList = categories
            dispatchGroup.leave()

        } failureCompletionBlock: { error in
            failureCompletionBlock(error)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.associateCategories(strongSelf.categoriesList, with: strongSelf.announcesList) { [weak self] announcesWithCategories in
                guard let strongSelf = self else { return }
                
                strongSelf.announcesList = announcesWithCategories.sorted()
                successCompletionBlock(strongSelf.announcesList, strongSelf.categoriesList)
                
            }
        }
    }
    
    
    /**
            assosciate each category to it's annouce
     */
    
    func associateCategories(_ categories: [Category],
                                     with announcesList: [Announce],
                                     completion: @escaping ([Announce]) -> Void) {
        
        var announces = announcesList
        for index in announces.indices {
            announces[index].category = categories.first(where: {$0.id == announces[index].categoryId})
        }
        
        completion(announces)
    }
    
}

