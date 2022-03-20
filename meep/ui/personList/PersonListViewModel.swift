//
//  PersonListViewModel.swift
//  meep
//
//  Created by Oğuzhan Aslan on 20.03.2022.
//

import Foundation

class PersonListViewModel: ViewModel {
    let personList : [Person] = [
        Person(id: "id", name: "name :1 ", age: "age:1 "),
        Person(id: "id", name: "name :2 ", age: "age:2 ")
    ]
}
