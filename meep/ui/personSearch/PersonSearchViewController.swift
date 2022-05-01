//
//  PersonSearchViewController.swift
//  meep
//
//  Created by Oğuzhan Aslan on 1.05.2022.
//

import Foundation
import UIKit

class PersonSearchViewController : UIViewController {
    
    
    let dummy = meepHeader2(text: "SEARCH")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        view.addSubview(dummy)
        dummy.snp.makeConstraints({ make in
            make.center.equalTo(self.view.snp.center)
        })
    }
    
}
