//
//  PersonRepository.swift
//  meep
//
//  Created by Oğuzhan Aslan on 25.03.2022.
//

import Foundation

class PersonRepository : PersonListInformationProvider {
    func getPersonList() -> [Person] {
        return  [
            Person(id: "id", name: "name :test1 ", age: "age:1 "),
            Person(id: "id", name: "name :2 ", age: "age:2 ")
        ]
    }
}
