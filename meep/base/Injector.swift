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
    
    func injectPersonInfoProvider() -> PersonListInformationProvider {
        registerDependencyIfNotRegistered(
            dependency: PersonRepository.self,
            onRegisterNeeded: { resolver in
                PersonRepository()
            }
        )
        return dependencyContainer.resolve(PersonRepository.self)!
    }
}
