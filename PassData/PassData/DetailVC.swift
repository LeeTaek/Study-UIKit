//
//  DetailVC.swift
//  PassData
//
//  Created by 이택성 on 2022/01/06.
//

import UIKit

class DetailVC: UIViewController {
    var someString = ""
    @IBOutlet weak var someLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someLabel.text = someString

    }


}
