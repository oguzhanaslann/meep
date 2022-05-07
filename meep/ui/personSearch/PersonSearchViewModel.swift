//
//  PersonSearchViewModel.swift
//  meep
//
//  Created by Oğuzhan Aslan on 5.05.2022.
//

import Foundation
import Combine

class PersonSearchViewModel : ViewModel {
    
    private let searchResultProvider : SearchResultProvider
    
    let subject = PassthroughSubject<[Person], Never>()
    let publisher: AnyPublisher<[Person], Never>
    
    init(searchResultProvider : SearchResultProvider) {
        self.searchResultProvider = searchResultProvider
        publisher = subject.eraseToAnyPublisher()
    }
    
    func onSearch(_ search : String) {
        searchResultProvider.searchPersonWithName(name: search) {
            
        } onComplation: { result in
            if let list = result.value {
                self.subject.send(list)
            }
        }

    }
    
    func doInitialSearch() {
        searchResultProvider.searchAnyPerson {
            
        } onComplation: { result in
            if let list = result.value {
                self.subject.send(list)
            }
        }

    }
}
