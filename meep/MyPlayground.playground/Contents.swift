import SQLite

do {
    let database = try  Connection(.inMemory)

    let userTable = Table("users")
    let id = Expression<String>("id")
    let firstName = Expression<String>("f_name")
    let lastName = Expression<String>("l_name")
    let email = Expression<String>("email")
    let birthdate = Expression<String>("dob")
    let phone = Expression<String>("phone")
    let profilePhoto = Expression<String>("profile_photo")
    let userLatitude = Expression<Double>("u_lat")
    let userLongtitude = Expression<Double>("u_lng")

    let addreess = Table("address")
    let latitude = Expression<Double>("lat")
    let longtitude = Expression<Double>("lng")
    let state = Expression<String>("state")
    let city = Expression<String>("city")
    let street = Expression<String>("street")

    print("pre")
    try database.transaction(block: {
        
        try database.run(
            addreess.create(ifNotExists: true, block: { tableBuilder in
                tableBuilder.column(longtitude)
                tableBuilder.column(latitude)
                tableBuilder.column(state)
                tableBuilder.column(city)
                tableBuilder.column(street)
                tableBuilder.primaryKey(latitude,longtitude)
            })
        )
        
        
        try database.run(
    
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
    })
    
    
    
    let userEntity = UserEntity(
        id: "String",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        birthdate: "birthdate",
        phone: "phone",
        profilePhoto: "profilePhoto",
        latitude: "0.0",
        longitude: "0.0",
        state: "state",
        street: "street",
        city: "city"
    )
    
    let addressInsert = addreess.insert(
        or: .replace,
        [
            latitude <- Double(userEntity.latitude) ?? 0.0 ,
            longtitude <- Double(userEntity.longitude) ?? 0.0,
            city <- userEntity.city,
            street <- userEntity.street,
            state <- userEntity.state
        ]
    )
    
    let query = userTable.insert(
        [
            id <- userEntity.id,
            firstName <- userEntity.firstName,
            lastName <- userEntity.lastName,
            email <- userEntity.email,
            birthdate <- userEntity.birthdate,
            phone <- userEntity.phone,
            profilePhoto <- userEntity.profilePhoto,
            userLatitude <- Double(userEntity.latitude) ?? 0.0 ,
            userLongtitude <- Double(userEntity.longitude) ?? 0.0
        ]
    )
    
//    try database.run(addressInsert)
    try database.run(query)
    
    
    let joinnedQuery = userTable.join(addreess, on: (userTable[userLatitude] == addreess[latitude]) && userTable[userLongtitude] == addreess[longtitude] )
       
//    let joinnedQuery = userTable
        
    let queryJoin = joinnedQuery.select(
            [
              id,
              firstName,
              lastName,
              email,
              birthdate,
              phone,
              profilePhoto,
              userLatitude,
              latitude,
              userLongtitude,
              city,
              street,
              state
            ]
        )
    
    let result =  try database.prepare(queryJoin)
    
    result.forEach { element in
        print("element \(element)")
    }
    
} catch let error  {
    print("error \(error)")
}

print("")
