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
    
    //MARK: methods
    
    /**
            recuperate announces and categories from NetworkLayer
     */
    
    func fetchAnnounces(successCompletionBlock: @escaping ([Announce], [Category]) -> Void,
                        failureCompletionBlock: @escaping (Error) -> Void) {

        var announcesList: [Announce] = []
        var categoriesList: [Category] = []
        
        let dispatchGroup = DispatchGroup()
            
        dispatchGroup.enter()
        NetworkManager.shared.listing { announces in
            announcesList = announces
            dispatchGroup.leave()

        } failureCompletionBlock: { error in
            failureCompletionBlock(error)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.categories { categories in
            categoriesList = categories
            dispatchGroup.leave()

        } failureCompletionBlock: { error in
            failureCompletionBlock(error)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.associateCategories(categoriesList, with: announcesList) { announcesWithCategories in
                successCompletionBlock(announcesWithCategories, categoriesList)
            }
        }
    }
    
    
    /**
            assosciate each category to it's annouce
     */
    
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

