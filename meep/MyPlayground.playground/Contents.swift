import UIKit
import Combine
import SQLite

let db = try Connection(.inMemory)
let user = Table("user")

let userTable = Table("users")
let id = Expression<String>("id")
let name = Expression<String>("name")
let userName = Expression<String?>("user_name")
let email = Expression<String>("email")
let birthdate = Expression<String>("dob")
let phone = Expression<String>("phone")
let profilePhoto = Expression<String>("profile_photo")



let addreess = Table("address")
let latitude = Expression<Double>("lat")
let longtitude = Expression<Double>("lng")
let state = Expression<String>("state")
let city = Expression<String>("city")
let street = Expression<String>("street")


try db.transaction {
    
    try db.run(
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
    
    try db.run(
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


try db.transaction {
    try db.run(addreess.insert(
        latitude <- 30.0,
        longtitude <- 30.0,
        state <- "state",
        city <- "city",
        street <- "street"
    ))
    
    try db.run(userTable.insert(
        id <- "id" ,
        name <- "name" ,
        userName <- "userName" ,
        email <- "email" ,
        birthdate <- "birthdate" ,
        phone <- "phone" ,
        profilePhoto <- "profilePhoto" ,
        latitude <- 30.0 ,
        longtitude <- 30.0
    ))
}



//print("asdad")
//
//let id  = Expression<Int64>("id")
//let name = Expression<String>("name")
//let userTable = Table("user")
//
//try db.run(
//    userTable.create(ifNotExists: true, block: { tableBuilder in
//        tableBuilder.column(id,primaryKey:.autoincrement)
//        tableBuilder.column(name)
//    })
//)
//
//
//do {
//    try db.transaction {
//        var rowId = try db.run(userTable.insert(name <- "Oğuzhan"))
//        rowId = try db.run(userTable.insert(name <- "Tunahan"))
//        rowId = try db.run(userTable.insert(name <- "Murat"))
//        rowId = try db.run(userTable.insert(name <- "Ayhan"))
//        print("rowId \(rowId)")
//
//        let users = try db.prepare(userTable)
//        for user in users {
//            print(user[name])
//        }
//
//        let user = userTable.select(name)
//            .filter(name.like("%han"))
//            .order(name)
//
//        let queryRes = try db.prepare(user)
//
//
//        queryRes.publisher.sink { op in
//            print(op)
//        }
//    }
//
//    try db.transaction {
//
//       try db.run(userTable.drop(ifExists: true))
//    }
//} catch {
//
//}
print("")
