//
//  NotiDetailViewController.swift
//  PassData
//
//  Created by 이택성 on 2022/01/07.
//

import UIKit

class NotiDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func notiAction(_ sender: Any) {
       
        let notificationName = Notification.Name("sendSomeString")
        
        let strDic = ["str" : "noti string"]

        
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: strDic)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
