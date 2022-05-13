//
//  ProfileViewController.swift
//  meep
//
//  Created by Oğuzhan Aslan on 1.05.2022.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {
      
    private let profileBackgroundView : UIStackView = {
        let stackView  = UIStackView()
        stackView.backgroundColor = primaryColor
        return stackView
    }()
    
    private let personProfilePhoto: UIImageView = meepImage(
        name: "sample",
        clipToBounds: true,
        borderColor: backgroundColor.cgColor,
        borderWidth: 2
    )
    
    private let settingsIcon : UIImageView =  meepSysImage(systemName : "")
    
    
    private let personName : UILabel =  meepHeader2(text: "Oğuzhan Aslan",color: onPrimaryColor)
    
    private let personUserName : UILabel =  meepHeader2(text: "#xx_crazy_boi_64")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        view.addSubview(profileBackgroundView)
        view.addSubview(personProfilePhoto)
        view.addSubview(personName)
        
        personProfilePhoto.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(72)
            make.left.equalToSuperview().offset(24)
            let dimensions = 180
            make.width.equalTo(dimensions)
            make.height.equalTo(dimensions)
            personProfilePhoto.layer.cornerRadius = CGFloat((dimensions / 2))
        }
        
        profileBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(personProfilePhoto.snp.centerY)
        }
        
        personName.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualTo(profileBackgroundView.snp.bottom).offset(-16)
            make.left.greaterThanOrEqualTo(personProfilePhoto.snp.right).offset(16)
        
        }
        
        
    }
}
