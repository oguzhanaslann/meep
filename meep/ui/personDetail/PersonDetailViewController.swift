//
//  PersonDetailViewController.swift
//  meep
//
//  Created by Oğuzhan Aslan on 20.03.2022.
//

import Foundation
import UIKit
import SnapKit
import MapKit
import Combine

class PersonDetailViewController : UIViewController {
  
    let personDetailViewModel = Inject.shared.injectPersonDetailViewModel()
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    init(personId: String){
        super.init(nibName: nil, bundle: nil)
        print("persondid : \(personId)")
        personDetailViewModel.setPersonId(personId: personId)
    }
    
    required init(coder : NSCoder){
        fatalError()
    }
    
    var observer : AnyCancellable? = nil
    
    private let personProfilePhoto: UIImageView = meepImage(
        name: "sample",
        clipToBounds: true,
        borderColor: backgroundColor.cgColor,
        borderWidth: 2
    )
    
    private let personName : UILabel =  meepHeader1(text: "Oğuzhan Aslan")
    
    private let personUserName : UILabel =  meepSubHeader2(text: "#xx_crazy_boi_64")
    
    private let contactsTitle : UILabel =  meepSubHeader2(text: "Contanct Information")
    
    private let emailText : UILabel = meepBody1(text: "Email : Oaslan@example.com")
    
    private let phoneText : UILabel = meepBody1(text: "Phone : (315)-001-3973")
    
    private let addressText : UILabel = meepBody1(text: "Address : waterford, kilcoole, 9278 new road ")
    
    
    private let navigateBackButton = meepSysImage(systemName: "arrow.left",tint: onPrimaryColor)
    
    
    private let profileBackgroundView : UIStackView = {
        let stackView  = UIStackView()
        stackView.backgroundColor = primaryColor
        return stackView
    }()
    
    
    private let personContactInfoContainer : UIStackView = {
        let contactInfoContainer = UIStackView()
        contactInfoContainer.backgroundColor = surfaceColor
        contactInfoContainer.layer.cornerRadius = 16 
        return contactInfoContainer
    }()
    
    
    private let personLocationMapView : MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 16
        map.setCenter(CLLocationCoordinate2DMake(20.9267, -7.9310), animated: true )
        map.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 100.0), animated: false)
        map.isZoomEnabled = false
        map.isUserInteractionEnabled  = true
        return map
    }()
    
    private let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp.edges)
        }
        
        scrollView.addSubview(personProfilePhoto)
        scrollView.addSubview(personName)
        scrollView.addSubview(personUserName)
        scrollView.addSubview(profileBackgroundView)
        scrollView.addSubview(personContactInfoContainer)
       
        
        let backgroundColor : UIColor = backgroundColor
        view.backgroundColor = backgroundColor
        personProfilePhoto.layer.borderColor = backgroundColor.cgColor

        personProfilePhoto.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.snp.top).offset(72)

            let dimensions = 200
            make.width.equalTo(dimensions)
            make.height.equalTo(dimensions)
            personProfilePhoto.layer.cornerRadius = CGFloat((dimensions / 2))
        }
        
        profileBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.right.equalTo(self.view.snp.right)
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(personProfilePhoto.snp.centerY)
        }
        
        
        profileBackgroundView.addSubview(navigateBackButton)
        
        navigateBackButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.left.equalToSuperview().offset(24)
            make.height.width.equalTo(30)
        }
        
        scrollView.bringSubviewToFront(personProfilePhoto);

        personName.snp.makeConstraints { make in
            make.top.equalTo(personProfilePhoto.snp.bottom).offset(16)
            make.centerX.equalTo(self.view.snp.centerX)
        }

        personUserName.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(personName.snp.bottom).offset(8)
        }
        
        personContactInfoContainer.snp.makeConstraints { make in
            make.top.equalTo(personUserName.snp.bottom).offset(16)
            make.right.equalTo(self.view.snp.right).offset(-16)
            make.left.equalTo(self.view.snp.left).offset(16)
            make.height.greaterThanOrEqualTo(150)
        }
        
        personContactInfoContainer.addSubview(contactsTitle)
        personContactInfoContainer.addSubview(emailText)
        personContactInfoContainer.addSubview(phoneText)
        personContactInfoContainer.addSubview(addressText)
        
        contactsTitle.snp.makeConstraints { make in
            make.top.equalTo(personContactInfoContainer.snp.top).offset(16)
            make.left.equalTo(personContactInfoContainer.snp.left).offset(16)
        }
        
        emailText.snp.makeConstraints { make in
            make.top.equalTo(contactsTitle.snp.bottom).offset(8)
            make.left.equalTo(personContactInfoContainer.snp.left).offset(16)
        }
        
        phoneText.snp.makeConstraints { make in
            make.top.equalTo(emailText.snp.bottom).offset(8)
            make.left.equalTo(personContactInfoContainer.snp.left).offset(16)
        }
        
        addressText.snp.makeConstraints { make in
            make.top.equalTo(phoneText.snp.bottom).offset(8)
            make.left.equalTo(personContactInfoContainer.snp.left).offset(16)
        }
        
        
        observer = personDetailViewModel.publisher.sink { personDetail in
            self.personProfilePhoto.load(url: personDetail.profilePhoto)
            self.personUserName.text = personDetail.userName
            self.personName.text = personDetail.fullName
            self.emailText.text = "Email : \(personDetail.contactInformation.email)"
            self.phoneText.text = "Phone : \(personDetail.contactInformation.phone)"
            self.addressText.text = "Address: \(personDetail.contactInformation.address)"
            self.personLocationMapView.setCenter(
                CLLocationCoordinate2D(
                    latitude: personDetail.location.latitude,
                    longitude: personDetail.location.longtitude
                ),
                animated: true
            )
        }
      
        personDetailViewModel.getPersonDetail()
      
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))

        navigateBackButton.isUserInteractionEnabled = true

        navigateBackButton.addGestureRecognizer(tapGestureRecognizer)

    }
    
    
    @objc func imageViewTapped(_ sender:AnyObject){
        _ = navigationController?.popViewController(animated: true)
        print("“imageview tapped”")

    }
    
    //Action
    func tapDetected() {
        print("Single Tap on imageview")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.addSubview(personLocationMapView)
        personLocationMapView.snp.makeConstraints { make in
            make.top.equalTo(personContactInfoContainer.snp.bottom).offset(16)
            make.right.equalTo(self.view.snp.right).offset(-16)
            make.left.equalTo(self.view.snp.left).offset(16)
            make.height.greaterThanOrEqualTo(300)
        }
    }
    

}
