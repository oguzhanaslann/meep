//
//  PersonSearchViewController.swift
//  meep
//
//  Created by Oğuzhan Aslan on 1.05.2022.
//

import Foundation
import UIKit
import Combine

class PersonSearchViewController : UIViewController {
    
    
    let searchViewModel : PersonSearchViewModel = Inject.shared.injectPersonSearchViewModel()
    
    let tableView: UITableView = UITableView()
    private var personList : [Person] = []
    
    var observer : AnyCancellable? = nil
    
    let searchContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = secondaryColor
        stackView.orientation(.vertical)
        return stackView
    }()
    
    let emailTextField : UITextField = {
        let myTextField: UITextField = UITextField()
        myTextField.placeholder = "Enter Person Name"
        myTextField.backgroundColor = surfaceColor
        myTextField.textColor = onSurfaceColor
        myTextField.layer.masksToBounds = true
        myTextField.clipsToBounds = true
        myTextField.layer.cornerRadius = 24
        myTextField.keyboardType = .default
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 30))
        myTextField.leftView = paddingView
        myTextField.rightView = paddingView
        myTextField.leftViewMode = .always
        myTextField.rightViewMode = .always
        return myTextField
    }()
    
    let searchTitle = meepHeader1(text: "Search People",color: onSecondaryColor)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        view.addSubview(tableView)
        view.addSubview(searchContainer)

        
        searchContainer.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(192)
            make.top.lessThanOrEqualTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        
        
        searchContainer.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualTo(self.searchContainer.snp.bottom).offset(-16)
            make.left.equalTo(self.searchContainer.snp.left).offset(16)
            make.right.equalTo(self.searchContainer.snp.right).offset(-16)
            make.height.equalTo(56)
        }
        
        
        searchContainer.addSubview(searchTitle)
        
        searchTitle.snp_makeConstraints { make in
            make.bottom.lessThanOrEqualTo(emailTextField.snp.top).offset(-8)
            make.left.equalTo(self.searchContainer.snp.left).offset(24)
            make.right.equalTo(self.searchContainer.snp.right).offset(24)
        }
        
        
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(self.searchContainer.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            tableView.backgroundColor = errorColor
            make.bottom.lessThanOrEqualToSuperview()
            make.height.greaterThanOrEqualTo(500)
        })
        
      
        emailTextField.addTarget(
                self,
                action: #selector(onSearch(_:)),
                for: .editingChanged
            )
            
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.register(PersonListCell.self, forCellReuseIdentifier: PersonListCell.identifier)
        
        
        observer = searchViewModel.publisher.sink(receiveValue: { people in
            NSLog("Search result received with size : \(people.count) ")
            self.personList = people
        })
        
    }
    
    @objc func onSearch(_ sender : UITextField) {
        let searchText = sender.text ?? ""
        print("search text -> \(sender.text)")
        searchViewModel.onSearch(searchText)
        tableView.reloadData()
    }
    
}



extension PersonSearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PersonListCell.identifier,
            for: indexPath
         ) as? PersonListCell
    
        if cell == nil {
            return UITableViewCell()
        }
        

        cell?.setCellWith(person: personList[indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("clicked %d", indexPath.row)
        let personId = personList[indexPath.row].id
        navigationController?.pushViewController(PersonDetailViewController(personId: personId), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
}

extension PersonSearchViewController: UITableViewDelegate{
    
}
