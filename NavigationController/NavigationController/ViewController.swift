//
//  ViewController.swift
//  NavigationController
//
//  Created by 이택성 on 2022/02/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNaviTitleImage()
        makeBackButton()
        
        makeRightAlarmbutton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        naviBackgroundDesign()

    }
    
    
    func makeRightAlarmbutton() {
//        let image = UIImage(systemName: "alarm")?.withRenderingMode(.alwaysOriginal)
//        let rightItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(rightItemClick))
//
//        let image2 = UIImage(systemName: "alarm.fill")?.withRenderingMode(.alwaysOriginal).withRenderingMode(.alwaysOriginal)
//        let rightItem2 = UIBarButtonItem(image: image2, style: .done, target: self, action: #selector(rightItemClick2))
//        rightItem2.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
//
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        
        let btn1 = UIButton()
        btn1.setImage(UIImage(systemName: "alarm", withConfiguration: config)?.withRenderingMode(.alwaysOriginal) , for: .normal)
        btn1.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let btn2 = UIButton()
        btn2.setImage(UIImage(systemName:"alarm.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn2.addTarget(self, action: #selector(rightItemClick2), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [btn1, btn2])
        stackView.axis = .horizontal
        stackView.spacing = 10                  // 사이의 공간
        stackView.distribution = .equalSpacing  //   떨어뜨린다
        
        
        let customItem = UIBarButtonItem(customView: stackView)
        
        self.navigationItem.rightBarButtonItem = customItem
        
//        self.navigationItem.rightBarButtonItems = [rightItem, rightItem2]
        
    }
    
    @objc func rightItemClick() {
        print("right item click")
    }
    
    @objc func rightItemClick2() {
        print("right item click")
    }
    
    
    
    
    
    
    
    
    func naviBackgroundDesign() {
        self.navigationController?.navigationBar.backgroundColor = .red
        self.navigationController?.navigationBar.isTranslucent = true       // 반투명 상태
        
        self.statusBar?.backgroundColor = .red
    }
    
    
    
    
    
    
    
    
    func makeBackButton() {
        
//        self.navigationItem.backButtonTitle = "뒤로가기"

//        self.navigationItem.backBarButtonItem = UIBarButtonItem(systemItem: .bookmarks)
//
//        var backImage = UIImage(systemName: "backward.frame.fill")
//        backImage =  backImage?.withRenderingMode(.alwaysOriginal)
//
        
        //  건들지 말고 원래 이미지 그대로 출력.
        guard let backImage = UIImage(systemName: "backward.frame.fill")?.withRenderingMode(.alwaysOriginal) else {
            return
        }


        let newImage = resizeImage(image: backImage, newWidth: 20, newHeight: 20)
        
        // 뒤로가기 이미지는 밑에 두개를 다 바꿔야 들어감.
        self.navigationController?.navigationBar.backIndicatorImage = newImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = newImage
        self.navigationController?.navigationBar.tintColor = .green
        
        self.navigationItem.backButtonTitle = ""
    }
    
    
    // 이미지 사이즈가 너무 커서 코드로 수정하는 경우, 이미지를 다시 만들어아햠.
    // 가장 좋은 방법은 파일 자체의 크기가 맞는 것이 좋다.
    func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage?{
        let newImageRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        // 빈 도화지를 다시 만든다.
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: newImageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    

    func setNaviTitleImage() {
        // 타이틀 텍스트로
//        self.navigationItem.title = "main title"
        
        // 타이틀 이미지로
//        let logo = UIImageView(image: UIImage(named: "starbuckLogo.jpg"))
//
//        logo.contentMode = .scaleAspectFit  // 이미지 비율 유지
//        logo.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//        navigationItem.titleView = logo
        
        
        // 타이틀 버튼으로
        let btn = UIButton()
//        btn.backgroundColor = .orange
        btn.setTitleColor(.blue, for: .normal)
        btn.setTitle("custom button", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        btn.addTarget(self, action: #selector(testAction), for: .touchUpInside)
     
        self.navigationItem.titleView
        = btn
        
    }
    
    
    @objc func testAction() {
        print("test action")
    }
    

}

