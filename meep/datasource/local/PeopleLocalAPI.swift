//
//  PeopleLocalAPI.swift
//  meep
//
//  Created by Oğuzhan Aslan on 2.04.2022.
//

import Foundation

protocol PeopleLocalAPI {
    func saveUser(userEntity : UserEntity)
    func saveUsers(userEntities: [UserEntity])
    func getAllUsers() -> [UserEntity]
}
