//
//  UserProfileInformation.swift
//  meep
//
//  Created by Oğuzhan Aslan on 22.07.2022.
//

import Foundation


struct UserProfileInformation {
    let name : String
    let profilePicture : String
    let friends : [Friend]
    let contactInformation :  ContactInformation
    let location : UserLocation
}
