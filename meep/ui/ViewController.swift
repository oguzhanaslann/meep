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
        1 - get data from repo
            1.1- use MVVM and publish library
            1.2- use ALOMIFIRE
        2 - save these data into local
        3-  connnect UI with these
        4-  on open detail page get id as parameter and load content with that. And, While doing that show lottie anim.
 
 */
class ViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    
    private let personListViewModel = Inject.shared.injectPersonListViewModel()
    private var personList : [Person] = []
    
    var observer : AnyCancellable? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.register(PersonListCell.self, forCellReuseIdentifier: PersonListCell.identifier)
        
        
        observer = personListViewModel.publisher.sink { personList in
            self.personList = (personList)
            self.tableView.reloadData()
        }
        
        personListViewModel.callPeopleList()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(self.view.snp.top).offset(36)
            make.bottom.equalTo(self.view.snp.bottom).offset(-36)
        }
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
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
        navigationController?.pushViewController(PersonDetailViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
}

extension ViewController: UITableViewDelegate{
    
}
