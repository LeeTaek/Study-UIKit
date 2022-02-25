//
//  ViewController.swift
//  CustomButton
//
//  Created by 이택성 on 2022/02/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myCustomButton: RotateButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCustomButton.selectTypeCallback = { upDownType in
            print(upDownType)
            
            if upDownType == .up {
                // source Code
            }
        }
        
        
        
        
        
        
//        let myButton = RotateButton()
//
//        self.view.addSubview(myButton)
//
//        myButton.translatesAutoresizingMaskIntoConstraints = false // 오토레이아웃.
//
//        // 화면 가운데 정렬
//        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//
//        //크기 설정
//        myButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        myButton.backgroundColor = UIColor.orange
//        myButton.setTitle("My Custom, Button", for: .normal)
//        myButton.setImage(UIImage(systemName: "arrow.down.square.fill"), for: .normal)
//
        
    }
}



