//
//  ProfileViewModel.swift
//  meep
//
//  Created by Oğuzhan Aslan on 21.07.2022.
//

import Foundation
import Combine

class ProfileViewModel {
    
    let subject = PassthroughSubject<UserProfileInformation, Never>()
    let publisher: AnyPublisher<UserProfileInformation, Never>
    let profileInfoProvider : ProfileInformationProvider
    
    init(profileInfoProvider : ProfileInformationProvider) {
        publisher = subject.eraseToAnyPublisher()
        self.profileInfoProvider =  profileInfoProvider
    }
    
    func getProfileInformation() {
        let profileInfo = self.profileInfoProvider.getUserProfileInformation()
        subject.send(profileInfo)
    }
}
