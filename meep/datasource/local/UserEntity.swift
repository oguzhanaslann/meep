//
//  UserEntity.swift
//  meep
//
//  Created by Oğuzhan Aslan on 10.04.2022.
//

import Foundation

struct UserEntity {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let birthdate: String
    let phone: String
    let profilePhoto: String
    let latitude: String
    let longitude: String
    let state: String
    let street: String
    let city: String
}


extension UserEntity {
    func toPerson() -> Person {
        return Person(id: self.id, firstName: self.firstName, lastName: self.lastName, age: self.birthdate, image: self.profilePhoto)
    }
}
