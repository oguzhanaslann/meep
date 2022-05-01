//
//  ViewController.swift
//  meep
//
//  Created by Oğuzhan Aslan on 12.03.2022.
//

import UIKit
import SnapKit
import Combine
import Alamofire
/*
    todo :
        2 - save these data into local
        3-  connnect UI with these
        4-  on open detail page get id as parameter and load content with that. And, While doing that show lottie anim.
 
 */
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let tabController = UITabBarController()
        
        tabController.setViewControllers([PersonListViewController()], animated: true)
        present(tabController, animated: false)
       
    }
}
