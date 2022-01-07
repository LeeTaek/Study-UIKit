//
//  InstanceViewViewController.swift
//  PassData
//
//  Created by 이택성 on 2022/01/07.
//

import UIKit

class InstanceViewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var mainVC: ViewController?             // mainVC로 가서 하픈거 하세요. 
    
    @IBAction func sendDataMainVC(_ sender: Any) {
        
        mainVC?.dataLabel.text = "some data"
        self.dismiss(animated: true, completion: nil)
    }
}
