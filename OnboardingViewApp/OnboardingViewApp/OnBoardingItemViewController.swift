//
//  OnBoardingItemViewController.swift
//  OnboardingViewApp
//
//  Created by 이택성 on 2022/01/20.
//

import UIKit

class OnBoardingItemViewController: UIViewController {
    
    var mainText = ""
    var subText = ""
    var topImage: UIImage? = UIImage()

    @IBOutlet private weak var topImageView: UIImageView!
    
    @IBOutlet private weak var mainTitleLable: UILabel!{
        didSet{
            descriptionLable.font = .systemFont(ofSize: 14, weight: .light)
        }
    }
    
    @IBOutlet private weak var descriptionLable: UILabel!{
        didSet{
            descriptionLable.font = .systemFont(ofSize: 20, weight: .medium )
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTitleLable.text = mainText
        topImageView.image = topImage
        descriptionLable.text = subText

    }
}
