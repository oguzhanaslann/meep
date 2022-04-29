//
//  PersonListViewModel.swift
//  meep
//
//  Created by Oğuzhan Aslan on 20.03.2022.
//

import Foundation
import Combine

class PersonListViewModel: ViewModel {
    
    private let personInfoProvider : PeopleListInformationProvider
    
    let subject = PassthroughSubject<[Person], Never>()
    let publisher: AnyPublisher<[Person], Never>
    
    init(personInfoProvider : PeopleListInformationProvider) {
        self.personInfoProvider = personInfoProvider
        publisher = subject.eraseToAnyPublisher()
    }
    
    func callPeopleList(){
        let list = personInfoProvider.getPersonList(
            onLoading: {},
            onComplation: { personListResult in
                if let list = personListResult.value {
                    self.subject.send(list)
                }
              
            }
        )
    }
}
