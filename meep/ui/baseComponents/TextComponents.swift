//
//  TextComponents.swift
//  meep
//
//  Created by Oğuzhan Aslan on 18.03.2022.
//

import Foundation
import UIKit

func meepHeader1(
    text : String,
    color : UIColor = .black,
    font : UIFont  = UIFont.boldSystemFont(ofSize: 28)
) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = color
    label.font = font
    return label
}

func meepHeader2(
    text : String,
    color : UIColor = .black,
    font : UIFont  = UIFont.boldSystemFont(ofSize: 24)
) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = color
    label.font = font
    return label
}

func meepSubHeader1(
    text : String,
    color : UIColor = .black,
    font : UIFont  = UIFont.boldSystemFont(ofSize: 18)
) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = color
    label.font = font
    return label
}


func meepSubHeader2(
    text : String,
    color : UIColor = .black,
    font : UIFont  = UIFont.boldSystemFont(ofSize: 16)
) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = color
    label.font = font
    return label
}


func meepBody1(
    text : String,
    color : UIColor = .black,
    font : UIFont  = .systemFont(ofSize: 16, weight: .regular)
) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = color
    label.font = font
    return label
}

func meepBody2(
    text : String,
    color : UIColor = .black,
    font : UIFont  = .systemFont(ofSize: 14, weight: .regular)
) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = color
    label.font = font
    return label
}


func meepCaption(
    text : String,
    color : UIColor = .gray,
    font : UIFont  = .systemFont(ofSize: 12)
) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = color
    label.font = font
    return label
}

func meepSysImage(
    systemName : String,
    clipToBounds : Bool? = nil,
    borderColor: CGColor? = nil,
    borderWidth : CGFloat? = nil,
    tint : UIColor? = nil
)  -> UIImageView {
    let image = UIImage(systemName: systemName)
    let imageView = UIImageView(image: image)
    
    if clipToBounds !=  nil {
        imageView.clipsToBounds = clipToBounds!
    }
    
    if borderColor !=  nil {
        imageView.layer.borderColor = borderColor!
    }
    
    if borderWidth !=  nil {
        imageView.layer.borderWidth = borderWidth!
    }
    
    if tint != nil {
        imageView.tintColor = tint!
    }
    
    return imageView
}

func meepImage (
    name : String,
    clipToBounds : Bool? = nil,
    borderColor: CGColor? = nil,
    borderWidth : CGFloat? = nil
)  -> UIImageView {
    let image = UIImage(named: name)
    let imageView = UIImageView(image: image)
    
    if clipToBounds !=  nil {
        imageView.clipsToBounds = clipToBounds!
    }
    
    if borderColor !=  nil {
        imageView.layer.borderColor = borderColor!
    }
    
    if borderWidth !=  nil {
        imageView.layer.borderWidth = borderWidth!
    }
    
    return imageView
}
