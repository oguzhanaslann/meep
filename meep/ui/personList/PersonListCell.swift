//
//  PersonListCell.swift
//  meep
//
//  Created by Oğuzhan Aslan on 18.03.2022.
//

import Foundation
import UIKit
import Kingfisher

class PersonListCell : UITableViewCell {
    
    public static let identifier : String = "PersonListCell"
   
    private let personProfilePhoto: UIImageView = meepImage(
        name: "sample",
        clipToBounds: true  ,
        borderColor: UIColor.blue.cgColor,
        borderWidth: 1
    )

    private let personName : UILabel =  meepSubHeader1(text: "Oğuzhan Aslan")

    private  let ageIcon : UIImageView = meepSysImage(systemName: "calendar.circle")
    
    private  let ageText :UILabel = meepCaption(text: "22")
    
    private  let contactIcon : UIImageView = meepSysImage(systemName: "arrow.right")
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(personProfilePhoto)
        contentView.addSubview(personName)
        contentView.addSubview(ageIcon)
        contentView.addSubview(ageText)
        contentView.addSubview(contactIcon)
        
        
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        personProfilePhoto.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.leftMargin.equalTo(8)
            let dimensions = 72
            make.width.equalTo(dimensions)
            make.height.equalTo(dimensions)
            personProfilePhoto.layer.cornerRadius = CGFloat((dimensions / 2))
                
        }
        
        
        personName.snp.makeConstraints { make in
            make.centerY.equalTo(personProfilePhoto.snp.centerY)
                .offset(-12)
            
            make.leading.equalTo(personProfilePhoto.snp.trailing)
                .offset(8)
            
            make.trailing.equalTo(self.contentView.snp.trailing)
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
            make.left.equalTo(ageIcon.snp.right).offset(4)
            make.right.lessThanOrEqualTo(self.contentView.snp.right).offset(-16)
        }
        
        contactIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView.snp.right).offset(-32)
        }
    }
        
    func setCellWith(person data  : Person) {
        personName.text = data.fullName
        ageText.text = data.age
        let url = URL(string: data.image)
        personProfilePhoto.kf.setImage(with: url)
    }
    
}
