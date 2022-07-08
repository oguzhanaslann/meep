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
class PersonListViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    let tableView: UITableView = UITableView()
    
    private let personListViewModel = Inject.shared.injectPersonListViewModel()
    private var personList : [Person] = []
    
    var observer : AnyCancellable? = nil
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        tableView.backgroundColor = backgroundColor
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
        
        
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization()
        self.sendNotification()
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { isGranted, error in
            if let error = error {
                  print("Error: ", error)
            }
        }
    }

    func sendNotification() {
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        notificationContent.title = "Test"
        notificationContent.body = "Test body"
        notificationContent.badge = NSNumber(value: 3)
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "testNotification",
            content: notificationContent,
            trigger: trigger
        )
        
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    var sentTime = 0
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("userNotificationCenter 1st")
        if sentTime < 5 {
            sentTime += 1
            sendNotification()
        }
        
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       
        print("userNotificationCenter 2nd")
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.sentTime < 5 {
                self.sentTime += 1
                self.sendNotification()
            }
        }
        
        completionHandler([.alert, .badge, .sound])
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

extension PersonListViewController : UITableViewDataSource {
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
        let personId = personList[indexPath.row].id
        navigationController?.pushViewController(PersonDetailViewController(personId: personId), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
}

extension PersonListViewController: UITableViewDelegate{
    
}
