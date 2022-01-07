//
//  DelegateDetailViewController.swift
//  PassData
//
//  Created by 이택성 on 2022/01/07.
// Delegate는 보통 protocol을 준수하는 것들만 만들도록 만듬

import UIKit


protocol DelegateDetailViewControllerDelegate: AnyObject {
    func passString(string: String)
    
}

class DelegateDetailViewController: UIViewController {
    weak var delegate: DelegateDetailViewControllerDelegate?    // 여기서 사용하는게 아니라 다른 곳에서 사용할수도, 안할수도 있고, 사용 끝내면 없애야 하기 떄문에 weak 타입 옵셔널.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func passDataToMainVC(_ sender: Any) {
        delegate?.passString(string: "delegate pass Data")
        self.dismiss(animated: true, completion: nil)
    }
}
