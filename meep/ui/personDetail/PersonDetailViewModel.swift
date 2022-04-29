//
//  PersonDetailViewModel.swift
//  meep
//
//  Created by Oğuzhan Aslan on 29.04.2022.
//

import Foundation
import Combine

class PersonDetailViewModel {
    
    private var personId : String? = nil
    private let personDetailInfoProvider:  PersonDetailInfoProvider
     
    let subject = PassthroughSubject<PersonDetail, Never>()
    let publisher: AnyPublisher<PersonDetail, Never>
    
    init(personDetailInfoProvider:  PersonDetailInfoProvider){
        self.personDetailInfoProvider = personDetailInfoProvider
        publisher = subject.eraseToAnyPublisher()
    }
    
    func setPersonId(personId : String) {
        self.personId = personId
    }
    
    func getPersonDetail() {
        personDetailInfoProvider.getPersonDetail(person: personId!) {
            print("loading person detail")
        } onComplation: { result in
            if let value = result.value {
                self.subject.send(value)
            }
        }

    }
}
