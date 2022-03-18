//
//  ViewController.swift
//  meep
//
//  Created by Oğuzhan Aslan on 12.03.2022.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    
    let personProfilePhoto: UIImageView = {
        let image = UIImage(named: "sample")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.layer.borderColor =  UIColor.blue.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
  
    let personName : UILabel =  meepSubHeader1(text: "Oğuzhan Aslan")

    let ageIcon : UIImageView = meepSysImage(systemName: "calendar.circle")
    
    let ageText :UILabel = meepCaption(text: "22")
    
    let contactIcon : UIImageView = meepSysImage(systemName: "arrow.right")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(personProfilePhoto)
        view.addSubview(personName)
        view.addSubview(ageIcon)
        view.addSubview(ageText)
        view.addSubview(contactIcon)
        
        
        personProfilePhoto.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.leftMargin.equalTo(8)
            let dimensions = 74
            make.width.equalTo(dimensions)
            make.height.equalTo(dimensions)
            personProfilePhoto.layer.cornerRadius = CGFloat((dimensions / 2))
        }
        
        
        personName.snp.makeConstraints { make in
            make.centerY.equalTo(personProfilePhoto.snp.centerY)
                .offset(-12)
            
            make.leading.equalTo(personProfilePhoto.snp.trailing)
                .offset(8)
            
            make.trailing.equalTo(self.view.snp.trailing)
                .inset(8)
       
        }
        
        
        ageIcon.snp.makeConstraints { make in
            make.centerY.equalTo(personProfilePhoto.snp.centerY)
                .offset(12)
            make.leading.equalTo(personProfilePhoto.snp.trailing)
                .offset(8)
        }
        
        
        ageText.snp.makeConstraints { make in
            make.top.equalTo(personName.snp.bottom).offset(8)
            make.left.equalTo(ageIcon.snp.left).offset(24)
            make.right.equalTo(self.view.snp.right).offset(-16)
        }
        
        contactIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.right.equalTo(self.view.snp.right).offset(-32)
        }
    }
}
