//
//  FriendCell.swift
//  meep
//
//  Created by Oğuzhan Aslan on 14.05.2022.
//

import Foundation
import UIKit

class FriendCell : UICollectionViewCell {
    
    public static let identifier = "FriendCell"
    
    public static func nib() -> UINib {
        return UINib(nibName: FriendCell.identifier + "nib", bundle: nil)
    }
    
    
    private  let friendImage: UIImageView = meepImage(name: "sample",borderColor: primaryColor.cgColor,borderWidth: 1)
    
    private let friendName : UILabel = meepCaption(text: "",color: onBackgroundColor)
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubview(friendName)
        contentView.addSubview(friendImage)
    }
    
    override func layoutSubviews() {
        setUpConstraints()
    }
    
    func setUpConstraints() {
        friendImage.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalToSuperview().offset(16)
            
//            make.centerY.equalTo(self.contentView)
//            make.leftMargin.equalTo(8)
            
            let dimensions = 64
            make.width.equalTo(dimensions)
            make.height.equalTo(dimensions)
            friendImage.layer.cornerRadius = CGFloat((dimensions / 2))
        }

//        friendImage.snp.makeConstraints { make in
//            make.centerX.equalTo(contentView.snp.centerX)
//            make.top.equalToSuperview().offset(16)
//            let dimensions = 72
//            make.width.equalTo(dimensions)
//            make.height.equalTo(dimensions)
//            friendImage.layer.cornerRadius = friendImage.frame.size.width / 2
//
//        }
        
       // friendImage.kf.setImage(with : URL(string : "https://picsum.photos/id/1/200/200"))
        
        friendName.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(friendImage.snp.bottom).offset(8)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    
    func setCellWith(imageUrl : String, name : String) {
        friendName.text = name
        let url = URL(string: imageUrl)
        friendImage.kf.setImage(with: url)
    }
        
}
