//
//  PersonDetail.swift
//  meep
//
//  Created by Oğuzhan Aslan on 29.04.2022.
//

import Foundation

struct PersonDetail{
    let id : String
    let fullName : String
    let userName : String
    let profilePhoto : String
    let contactInformation :  ContactInformation
    let location : UserLocation
}

struct ContactInformation {
    let email : String
    let phone : String
    let address : String
}

struct UserLocation {
    let latitude : Double
    let longtitude : Double
}
