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
    
    private let settingsIcon : UIImageView =  meepSysImage(systemName : "ellipsis")
    
    
    private let personName : UILabel =  meepHeader2(text: "Oğuzhan Aslan",color: onPrimaryColor)
    
    private let personUserName : UILabel =  meepHeader2(text: "#xx_crazy_boi_64")
    
    private let friendsHeader : UILabel = meepSubHeader1(text: "Friends")
    
    
    
    private let friendsList : UICollectionView = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.collectionView?.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = backgroundColor
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        view.addSubview(profileBackgroundView)
        view.addSubview(personProfilePhoto)
        view.addSubview(personName)
        view.addSubview(friendsList)
        view.addSubview(friendsHeader)
        view.addSubview(settingsIcon)
        friendsList.dataSource = self
        friendsList.delegate = self

        
        friendsList.register(FriendCell.self, forCellWithReuseIdentifier: FriendCell.identifier)
        
        personProfilePhoto.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(72)
            make.left.equalToSuperview().offset(24)
            let dimensions = 180
            make.width.equalTo(dimensions)
            make.height.equalTo(dimensions)
            personProfilePhoto.layer.cornerRadius = CGFloat((dimensions / 2))
        }
        
        // personProfilePhoto.kf.setImage(with : URL(string : "https://picsum.photos/id/1/200/200"))
        
        friendsHeader.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(personProfilePhoto.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(16)
        }
        
        friendsList.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(friendsHeader.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(120)
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
        
        settingsIcon.snp.makeConstraints { make in
            make.top.equalTo(profileBackgroundView.snp.top).offset(48)
            make.right.equalTo(profileBackgroundView.snp.right).offset(-36)
            settingsIcon.tint(color: UIColor.white)
            settingsIcon.transform = settingsIcon.transform.rotated(by: .pi / 2)
        }
        
        self.view.bringSubviewToFront(settingsIcon)
        
        
    }
}



extension ProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCell.identifier, for: indexPath) as? FriendCell
        
        guard cell != nil else {
            return UICollectionViewCell()
        }
        
        cell?.setCellWith(imageUrl: "https://picsum.photos/id/1/200/200", name: "name")
        
//        cell?.layer.borderColor = UIColor.white.cgColor
//        cell?.layer.borderWidth = 2
        
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 72, height: 120)
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        // handle click
    
    }
   
        
    
}
