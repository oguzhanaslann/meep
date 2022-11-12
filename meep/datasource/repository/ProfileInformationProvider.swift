//
//  ProfileInformationProvider.swift
//  meep
//
//  Created by Oğuzhan Aslan on 22.07.2022.
//

import Foundation

protocol ProfileInformationProvider {
    
    func getUserFriends() -> [Friend]
    func getUserProfileInformation() -> UserProfileInformation
    
}


