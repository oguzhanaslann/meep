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
    func insertUserEntities(users:[UserEntity])
    func getUserWith(id : String) ->  UserEntity?
    func getAllUsers() -> [UserEntity]
    func getUsersWithNameLike(_ name : String) -> [UserEntity]
    
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
           print("Could not connect the database")
       }
    }

    init() {
        initDataBaseIfNeeded()
        prepare()
    }
    
    private let userTable = Table("users")
    private let id = Expression<String>("id")
    private let firstName = Expression<String>("f_name")
    private let lastName = Expression<String>("l_name")
    private let email = Expression<String>("email")
    private let birthdate = Expression<String>("dob")
    private let phone = Expression<String>("phone")
    private let profilePhoto = Expression<String>("profile_photo")
    private let userLatitude = Expression<Double>("u_lat")
    private let userLongtitude = Expression<Double>("u_lng")
        
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
                        tableBuilder.column(firstName)
                        tableBuilder.column(lastName)
                        tableBuilder.column(email)
                        tableBuilder.column(birthdate)
                        tableBuilder.column(phone)
                        tableBuilder.column(profilePhoto)
                        tableBuilder.column(userLatitude)
                        tableBuilder.column(userLongtitude)
                        tableBuilder.foreignKey(userLatitude, references: addreess, latitude, delete: .setNull)
                        tableBuilder.foreignKey(userLongtitude, references: addreess, longtitude, delete: .setNull)
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
            print("prepare error")
        }
    }

    func insertUserEntity(user: UserEntity) {
        
        
        let addressInsertQuery = addreess.insert(
            or: .replace,
            [
                self.latitude <- Double(user.latitude) ?? 0.0 ,
                self.longtitude <- Double(user.longitude) ?? 0.0,
                self.city <- user.city,
                self.street <- user.street,
                self.state <- user.state
            ]
        )
        
        let userTableInsertQuery = userTable.insert(
            or: .replace,
            [
                self.id <- user.id,
                firstName <- user.firstName,
                lastName <- user.lastName,
                email <- user.email,
                birthdate <- user.birthdate,
                phone <- user.phone,
                profilePhoto <- user.profilePhoto,
                self.userLatitude <- Double(user.latitude) ?? 0.0 ,
                self.userLongtitude <- Double(user.longitude) ?? 0.0,
            ]
        )
        
        
        do {
            let addressInsert =  try database?.run(addressInsertQuery)
            let userInsert = try database?.run(userTableInsertQuery)
            
            print("address inserted : \(String(describing: addressInsert))")
            print("user inserted : \(String(describing: userInsert))")
            
        } catch let error  {
            print("insertUserEntity error : \(error.localizedDescription)")
        }
    }

    func insertUserEntity(user: UserEntity...) {
        user.forEach { userEntity in
            insertUserEntity(user: userEntity)
        }
    }
    
    func insertUserEntities(users: [UserEntity]) {
        users.forEach { userEntity in
            insertUserEntity(user: userEntity)
        }
    }

    func getUserWith(id: String) -> UserEntity?{
    
        let joinnedQuery = userTable.join(
            addreess,
            on: (userTable[userLatitude] == addreess[latitude]) && userTable[userLongtitude] == addreess[longtitude]
        ).select(
                [
                  self.id,
                  firstName,
                  lastName,
                  email,
                  birthdate,
                  phone,
                  profilePhoto,
                  latitude,
                  longtitude,
                  state,
                  city,
                  street
                ]
            ).filter(
                self.id == id
            )

        do {
            let result =  try database?.prepare(joinnedQuery)
            let user = try  result?.first(where: { row in
                try row.get(self.id) == id
            })
            
            
            
            if user != nil {
                
                return UserEntity(
                    id: try user?.get(self.id) ?? "",
                    firstName: try user?.get(firstName) ?? "",
                    lastName: try user?.get(lastName) ?? "",
                    email: try  user?.get(email) ?? "",
                    birthdate: try user?.get(birthdate) ?? "",
                    phone: try user?.get(phone) ?? "",
                    profilePhoto: try  user?.get(profilePhoto) ?? "",
                    latitude: try String(user?.get(latitude) ?? 0.0 ) ,
                    longitude: try String(user?.get(longtitude) ?? 0.0 ) ,
                    state: try user?.get(state) ?? "",
                    street: try user?.get(street) ?? "",
                    city: try user?.get(city) ?? ""
                )
                
            } else {
                return nil
            }

        } catch let error {
            print("getUserWith: error \(error.localizedDescription)")
            return nil 
        }
    }
    
    func getAllUsers() -> [UserEntity] {
        
        let joinnedQuery = userTable.join(addreess, on: (userTable[userLatitude] == addreess[latitude]) && userTable[userLongtitude] == addreess[longtitude] )
            .select(
                [
                  self.id,
                  firstName,
                  lastName,
                  email,
                  birthdate,
                  phone,
                  profilePhoto,
                  latitude,
                  longtitude,
                  state,
                  city,
                  street
                ]
            )

        
        
        var userEntities : [UserEntity] = []
        do {
            let result =  try database?.prepare(joinnedQuery)
            
            try result?.forEach({ user  in
                userEntities.append(
                    UserEntity(
                        id: try user.get(self.id),
                        firstName: try user.get(firstName),
                        lastName: try user.get(lastName),
                        email: try  user.get(email),
                        birthdate: try user.get(birthdate),
                        phone: try user.get(phone),
                        profilePhoto: try  user.get(profilePhoto) ,
                        latitude: try String(user.get(latitude) ) ,
                        longitude: try String(user.get(longtitude) ) ,
                        state: try user.get(state) ,
                        street: try user.get(street) ,
                        city: try user.get(city)
                    )
                )
            })
        } catch {
            print("getAllUsers error")
        }
        
        
        return userEntities
    }
    
    func getUsersWithNameLike(_ name: String) -> [UserEntity] {
        let joinnedQuery = userTable.join(addreess, on: (userTable[userLatitude] == addreess[latitude]) && userTable[userLongtitude] == addreess[longtitude] )
            .select(
                [
                  self.id,
                  firstName,
                  lastName,
                  email,
                  birthdate,
                  phone,
                  profilePhoto,
                  latitude,
                  longtitude,
                  state,
                  city,
                  street
                ]
            )
            .filter(
                self.firstName.like("%\(name)%") || self.lastName.like("%\(name)%")
            )
        
        var userEntities : [UserEntity] = []
        
        do {
            let result = try database?.prepare(joinnedQuery)
            try result?.forEach({ user  in
                userEntities.append(
                    UserEntity(
                        id: try user.get(self.id),
                        firstName: try user.get(firstName),
                        lastName: try user.get(lastName),
                        email: try  user.get(email),
                        birthdate: try user.get(birthdate),
                        phone: try user.get(phone),
                        profilePhoto: try  user.get(profilePhoto) ,
                        latitude: try String(user.get(latitude) ) ,
                        longitude: try String(user.get(longtitude) ) ,
                        state: try user.get(state) ,
                        street: try user.get(street) ,
                        city: try user.get(city)
                    )
                )
            })
            
        } catch let error {
            print("Error while searching users with name: \(name) , problem -> \(error.localizedDescription)")
        }
        
        return userEntities
    }
    
    
}
