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
    
    func getUser(id: String) -> UserEntity? {
        return peopleDB.getUserWith(id: id)
    }
    
    func getUserWithSimilarName(with name: String) -> [UserEntity] {
        return peopleDB.getUsersWithNameLike(name)
    }
   
}
