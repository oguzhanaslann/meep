//
//  PeopleDatabase.swift
//  meep
//
//  Created by Oğuzhan Aslan on 10.04.2022.
//

import Foundation
import SQLite

protocol PeopleDatabase {
    func insertUserEntity(user: UserEntity)
    func insertUserEntity(user: UserEntity...)
    func getUserWith(id : String) ->  UserEntity
}

class PeopleSqlLiteDatabase : PeopleDatabase {

    public static var shared : PeopleSqlLiteDatabase  = {
        return PeopleSqlLiteDatabase()
    }()
    
    private var _database : Connection? = nil
    var database: Connection? {
        get {
            initDataBaseIfNeeded()
            return _database
        }
    }
    
   private func initDataBaseIfNeeded(){
       do {
            if _database == nil {
                _database = try Connection(.inMemory)
            }
       } catch {

       }
    }

    init() {
        initDataBaseIfNeeded()
        prepare()
    }
    
    private let userTable = Table("users")
    private let id = Expression<String>("id")
    private let name = Expression<String>("name")
    private let userName = Expression<String?>("user_name")
    private let email = Expression<String>("email")
    private let birthdate = Expression<String>("dob")
    private let phone = Expression<String>("phone")
    private let profilePhoto = Expression<String>("profile_photo")
        
    private let addreess = Table("address")
    private let latitude = Expression<Double>("lat")
    private let longtitude = Expression<Double>("lng")
    private let state = Expression<String>("state")
    private let city = Expression<String>("city")
    private let street = Expression<String>("street")
    
    private func prepare() {
        initDataBaseIfNeeded()
        do {
            try database?.transaction {
                try database?.run(
                    userTable.create(ifNotExists: true, block: { tableBuilder in
                        tableBuilder.column(id,primaryKey: true)
                        tableBuilder.column(name)
                        tableBuilder.column(userName)
                        tableBuilder.column(email)
                        tableBuilder.column(birthdate)
                        tableBuilder.column(phone)
                        tableBuilder.column(profilePhoto)
                        tableBuilder.column(latitude)
                        tableBuilder.column(longtitude)
                        tableBuilder.foreignKey(latitude, references: addreess, latitude, delete: .setNull)
                        tableBuilder.foreignKey(longtitude, references: addreess, longtitude, delete: .setNull)
                    })
                )
                
                try database?.run(
                    addreess.create(ifNotExists: true, block: { tableBuilder in
                        tableBuilder.column(latitude)
                        tableBuilder.column(longtitude)
                        tableBuilder.column(state)
                        tableBuilder.column(city)
                        tableBuilder.column(street)
                        tableBuilder.primaryKey(latitude,longtitude)
                    })
                )
            }
        } catch {
            
        }
    }

    func insertUserEntity(user: UserEntity) {
        
    }

    func insertUserEntity(user: UserEntity...) {
        
    }

    func getUserWith(id: String) -> UserEntity{
        
        try database?.run(
            userTable.select()
                .where(id.like(id)
        )
        
        return UserEntity()
    }
            
}
