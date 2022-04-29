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
}
