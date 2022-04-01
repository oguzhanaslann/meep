//
//  PersonListViewModel.swift
//  meep
//
//  Created by Oğuzhan Aslan on 20.03.2022.
//

import Foundation
import Combine

class PersonListViewModel: ViewModel {
    
    private let personInfoProvider : PersonListInformationProvider
    
    let subject = PassthroughSubject<[Person], Never>()
    let publisher: AnyPublisher<[Person], Never>
    
    init(personInfoProvider : PersonListInformationProvider) {
        self.personInfoProvider = personInfoProvider
        publisher = subject.eraseToAnyPublisher()
    }
    
    func callPeopleList(){
        let list = personInfoProvider.getPersonList()
        subject.send(list)
    }
}
