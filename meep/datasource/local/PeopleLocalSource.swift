//
//  PeopleLocalSource.swift
//  meep
//
//  Created by Oğuzhan Aslan on 2.04.2022.
//

import Foundation


class PeopleLocalSource : PeopleLocalAPI {

    let peopleDB : PeopleDatabase

    init(peopleDb: PeopleDatabase) {
        self.peopleDB = peopleDb
    }
    
    
    func saveUser(userEntity: UserEntity) {
        peopleDB.insertUserEntity(user: userEntity)
    }
    
    func saveUsers(userEntities: [UserEntity]) {
        peopleDB.insertUserEntities(users: userEntities)
    }
    
    func getAllUsers() -> [UserEntity] {
        return peopleDB.getAllUsers()
    }
    
}
