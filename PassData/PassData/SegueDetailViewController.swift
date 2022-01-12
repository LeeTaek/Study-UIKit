//
//  SegueDetailViewController.swift
//  PassData
//
//  Created by 이택성 on 2022/01/07.
//

import UIKit

class SegueDetailViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    
    
    var dataString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataLabel.text = dataString
    }
}
