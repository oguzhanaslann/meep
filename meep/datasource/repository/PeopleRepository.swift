//
//  PersonRepository.swift
//  meep
//
//  Created by Oğuzhan Aslan on 25.03.2022.
//

import Foundation

class PeopleRepository : PeopleListInformationProvider,PersonDetailInfoProvider,SearchResultProvider {

    private let peopleLocalAPI : PeopleLocalAPI
    private let peopleNetworkAPI : PeopleNetworkAPI
    
    init(peopleLocalAPI : PeopleLocalAPI,peopleNetworkAPI : PeopleNetworkAPI){
        self.peopleLocalAPI = peopleLocalAPI
        self.peopleNetworkAPI = peopleNetworkAPI
    }
    
    
    func getPersonList(
        onLoading : @escaping () -> Void,
        onComplation : @escaping  (AnyResult<[Person]>) -> Void
    ) {
        peopleNetworkAPI.fetchPeopleList(onLoading: onLoading, onComplation: { result in
            let peopleResult:  AnyResult<[Person]> =  result.map { apiResponse in
               
                var userEntities : [UserEntity] = []
                
                if  let apiResponse = result.value {
                   
                    apiResponse.results?.forEach({ result  in
                        
                        userEntities.append(
                            UserEntity(
                                id: result.id?.value ?? "",
                                firstName : result.name?.first  ?? "",
                                lastName: result.name?.last ?? "",
                                email: result.email ?? "",
                                birthdate: result.dob?.date ?? "",
                                phone: result.phone ?? "",
                                profilePhoto: result.picture?.large ?? "",
                                latitude: result.location?.coordinates?.latitude ?? "",
                                longitude: result.location?.coordinates?.longitude ?? "",
                                state: result.location?.state ?? "",
                                street: result.location?.street?.name ?? "",
                                city: result.location?.city ?? ""
                            )
                        )
                    })
                }
                
                self.peopleLocalAPI.saveUsers(userEntities: userEntities)
              
                let people = self.peopleLocalAPI.getAllUsers().map { userEntity  in
                    userEntity.toPerson()
                }
                
                return AnyResult.success(people)
            }
            
            onComplation(peopleResult)
        })
    }
    
    func getPersonDetail(person : String , onLoading: @escaping () -> Void, onComplation: @escaping (AnyResult<PersonDetail>) -> Void) {
        onLoading()
        var result : AnyResult<PersonDetail> = AnyResult.failure(error:UnknownError())
        let userEntity = peopleLocalAPI.getUser(id: person)
        if userEntity != nil {
            let personDetail = PersonDetail(
                id: userEntity?.id ?? "",
                fullName: userEntity?.fullName() ?? "",
                userName: userEntity?.fullName() ?? "",
                profilePhoto: userEntity?.profilePhoto ?? "",
                contactInformation: ContactInformation(
                    email: userEntity?.email ?? "" ,
                    phone: userEntity?.phone ?? "",
                    address: userEntity?.address() ?? ""
                ),
                location: UserLocation(
                    latitude: Double(userEntity?.latitude ?? "0.0") ?? 0.0  ,
                    longtitude: Double(userEntity?.longitude ?? "0.0") ?? 0.0
                )
            )
            
            result = AnyResult.success(personDetail)
        }
        
        onComplation(result)
    }
    
    func searchPersonWithName(name: String, onLoading: @escaping () -> Void, onComplation: @escaping (AnyResult<[Person]>) -> Void) {
        let userList =  self.peopleLocalAPI.getUserWithSimilarName(with : name)
        
        let people = userList.map { entity in
            entity.toPerson()
        }
        
        onComplation(AnyResult.success(people))
    }
    
}

class UnknownError : Error {
    
}
