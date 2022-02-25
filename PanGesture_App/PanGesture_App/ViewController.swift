 //
//  ViewController.swift
//  PanGesture_App
//
//  Created by 이택성 on 2022/01/20.
//

import UIKit

enum DragType {
    case x
    case y
    case none
}

class ViewController: UIViewController {

    var dragType = DragType.none
    let myView = DraggableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.backgroundColor = .red

        myView.dragType = .x
        self.view.addSubview(myView)
    }

    @IBAction func selectPanType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0 :
            dragType = .x
        case 1:
            dragType = .y
        case 2:
            dragType = .none
        default :
            break
        }
        
        myView.dragType = self.dragType
    }
}

