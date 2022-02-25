//
//  ViewController.swift
//  OnboardingViewApp
//
//  Created by 이택성 on 2022/01/20.
//

import UIKit

class ViewController: UIViewController {
    
    var didShowOnboardingView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {        // 얘는 띄우기 직전. 얘도 안됨.
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {         // 화면이 구성된 후 띄우는 것, 메인 화면이 보일때마다 호출됨.
        super.viewDidAppear(animated)
        
        if didShowOnboardingView == false{
        
            didShowOnboardingView = true
            
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
            
            pageVC.modalPresentationStyle = .fullScreen
            
            self.present(pageVC, animated: true, completion: nil)
        }
 
        
    }

    
}

