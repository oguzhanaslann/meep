//
//  Injector.swift
//  meep
//
//  Created by Oğuzhan Aslan on 20.03.2022.
//

import Foundation
import Swinject
let dependencyContainer  = Container()
class Inject {
    public static let shared = Inject()
    private init() {}
    
    private func registerDependencyIfNotRegistered<T>(dependency : T.Type, onRegisterNeeded : @escaping ( Resolver ) -> T ) {
        if dependencyContainer.resolve(dependency.self) == nil  {
            dependencyContainer.register(dependency) { resolver in
                onRegisterNeeded(resolver)
            }
        }
    }
    
    func injectPersonListViewModel() -> PersonListViewModel{
        registerDependencyIfNotRegistered(
            dependency: PersonListViewModel.self,
            onRegisterNeeded: { resolver in
                PersonListViewModel(
                    personInfoProvider: self.injectPersonInfoProvider()
                )
            }
        )
        return dependencyContainer.resolve(PersonListViewModel.self)!
    }
    
    func injectPersonInfoProvider() -> PeopleListInformationProvider {
       return injectPeopleRepository()
    }
    
    func injectPeopleRepository() -> PeopleRepository {
        registerDependencyIfNotRegistered(
            dependency: PeopleRepository.self,
            onRegisterNeeded: { resolver in
                PeopleRepository(
                    peopleLocalAPI: self.injectPeopleLocalAPI(),
                    peopleNetworkAPI: self.injectPeopleNetworkAPI()
                )
            }
        )
        return dependencyContainer.resolve(PeopleRepository.self)!
    }
    
    func injectPeopleLocalAPI() -> PeopleLocalAPI {
        return injectPeopleLocalSource()
    }
    
    func injectPeopleLocalSource() -> PeopleLocalSource {
        registerDependencyIfNotRegistered(
            dependency: PeopleLocalSource.self,
            onRegisterNeeded: { resolver in
                PeopleLocalSource(
                    peopleDb: PeopleSqlLiteDatabase.shared
                )
            }
        )
        return dependencyContainer.resolve(PeopleLocalSource.self)!
    }
    
    func injectPeopleNetworkAPI() -> PeopleNetworkAPI{
        registerDependencyIfNotRegistered(
            dependency: RandomUserClient.self,
            onRegisterNeeded: { resolver in
                RandomUserClient()
            }
        )
        return dependencyContainer.resolve(RandomUserClient.self)!
    }
    
    func injectPersonDetailViewModel() -> PersonDetailViewModel {
        registerDependencyIfNotRegistered(
            dependency: PersonDetailViewModel.self,
            onRegisterNeeded: { resolver in
                PersonDetailViewModel(
                    personDetailInfoProvider: self.injectPersonInfoProvider()
                )
            }
        )
        return dependencyContainer.resolve(PersonDetailViewModel.self)!
    }
    
    
    func injectPersonInfoProvider() -> PersonDetailInfoProvider {
        registerDependencyIfNotRegistered(
            dependency: PeopleRepository.self,
            onRegisterNeeded: { resolver in
                PeopleRepository(
                    peopleLocalAPI: self.injectPeopleLocalAPI(),
                    peopleNetworkAPI: self.injectPeopleNetworkAPI()
                )
            }
        )
        return dependencyContainer.resolve(PeopleRepository.self)!
    }
    
    
    func injectPersonSearchViewModel() -> PersonSearchViewModel {
        registerDependencyIfNotRegistered(
            dependency: PersonSearchViewModel.self,
            onRegisterNeeded: { resolver in
                PersonSearchViewModel(
                    searchResultProvider: self.injectSearchResultProvider()
                )
            }
        )
        return dependencyContainer.resolve(PersonSearchViewModel.self)!
    }
    
    func injectSearchResultProvider() -> SearchResultProvider {
        return injectPeopleRepository()
    }
    
    func injectProfileViewModel() -> ProfileViewModel {
        registerDependencyIfNotRegistered(dependency: ProfileViewModel.self) { resolver in
            ProfileViewModel(profileInfoProvider: dummy())
        }
        
        return dependencyContainer.resolve(ProfileViewModel.self)!
    }
}

class dummy : ProfileInformationProvider {
    func getUserFriends() -> [Friend] {
        return []
    }
    
    func getUserProfileInformation() -> UserProfileInformation {
        return UserProfileInformation(
            name: "",
            profilePicture: "",
            friends: [
                Friend(id: "1", name: "Ali", image: "https://picsum.photos/id/1/200/200"),
                Friend(id: "2", name: "Veli", image: "https://picsum.photos/id/1/200/200"),
                Friend(id: "3", name: "Mahmut", image: "https://picsum.photos/id/1/200/200"),
                Friend(id: "4", name: "Şaban", image: "https://picsum.photos/id/1/200/200"),
            ],
            contactInformation: ContactInformation(email: "", phone: "", address: ""),
            location: UserLocation(latitude: 0.0, longtitude: 0.0)
        )
    }
    
    
}
