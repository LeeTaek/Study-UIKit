//
//  ClosureDetailViewController.swift
//  PassData
//
//  Created by 이택성 on 2022/01/07.
//

import UIKit

class ClosureDetailViewController: UIViewController {
    var myClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closurePassData(_ sender: Any) {
        myClosure?("closure string")
        self.dismiss(animated: true, completion: nil)
    }
}
