//
//  MyIDViewController.swift
//  Setting_Clone_APP
//
//  Created by 이택성 on 2022/01/17.
//

import UIKit

class MyIDViewController: UIViewController {

    @IBOutlet weak var nextBotton: UIButton!
    @IBOutlet weak var cancelBotton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.addTarget(self, action: #selector(textFiledDidChange), for: .editingChanged)
        
        // but. 입력할 때에 호출되기 때문에 처음에 화면이 뜰 때에 next가 활성화 되어있음.
        // 아래 중에 하나 고를 수 있음. 어떤게 더 적절할지 고민해봐야함
//        didset
        textFiledDidChange(sender: emailTextField)
//        nextBotton.isEnabled = false
//
    }

    
    @objc func textFiledDidChange(sender: UITextField) {            // selector 로 부를 함수는 @objc 키워드가 들어가야함
        
        if sender.text?.isEmpty == true {
            nextBotton.isEnabled = false
        } else {
            nextBotton.isEnabled = true
        }
    }
    
}
