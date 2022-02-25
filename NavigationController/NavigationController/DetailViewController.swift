//
//  DetailViewController.swift
//  NavigationController
//
//  Created by 이택성 on 2022/02/07.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = .yellow
        
        self.statusBar?.backgroundColor = .yellow

        
    }
}

extension UIViewController {
    
    var statusBar: UIView?{
        // status bar 디자인
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.statusBarView.backgroundColor = .yellow
        
        // Scene 기반. ios 15 이상
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window2 = windowScene?.windows.first
        
        // ios 14 이하
        let window = UIApplication.shared.windows.filter{ $0.isKeyWindow }.first

        if let hasStatusBar = sceneDelegate?.statusBarView {
            window2?.addSubview(hasStatusBar)
            
        }
  
        return sceneDelegate?.statusBarView

    }
}
