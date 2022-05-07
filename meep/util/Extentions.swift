//
//  Extentions.swift
//  meep
//
//  Created by Oğuzhan Aslan on 12.03.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func load(url : String) {
        let url = URL(string: url)
        self.kf.setImage(with: url)
    }
}

extension UIStackView {
    func orientation(_ orientation : NSLayoutConstraint.Axis) {
        self.axis = orientation
    }
}
