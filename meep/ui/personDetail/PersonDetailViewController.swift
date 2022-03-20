//
//  PersonDetailViewController.swift
//  meep
//
//  Created by Oğuzhan Aslan on 20.03.2022.
//

import Foundation
import UIKit
import SnapKit

class PersonDetailViewController : UIViewController {
   

    private let personProfilePhoto: UIImageView = meepImage(
        name: "sample",
        clipToBounds: true,
        borderWidth: 2
    )
    
    private let personName : UILabel =  meepHeader1(text: "Oğuzhan Aslan")
    
    private let personUserName : UILabel =  meepHeader2(text: "#xx_crazy_boi_64")
    
    private let contactsTitle : UILabel =  meepSubHeader1(text: "Contanct Information")
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(personProfilePhoto)
        view.addSubview(personName)
        view.addSubview(personUserName)
        view.addSubview(profileBackgroundView)
        view.addSubview(personContactInfoContainer)
        
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
            make.top.equalTo(self.view.snp.top).offset(36)
            make.right.equalTo(self.view.snp.right)
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(personProfilePhoto.snp.centerY)
        }
        
        self.view.bringSubviewToFront(personProfilePhoto);

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
        
        contactsTitle.snp.makeConstraints { make in
            make.top.equalTo(personContactInfoContainer.snp.top).offset(16)
            make.left.equalTo(personContactInfoContainer.snp.left).offset(16)
            
        }
        
        
    }
}
