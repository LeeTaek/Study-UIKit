//
//  ViewController.swift
//  App_Start
//
//  Created by 이택성 on 2022/01/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testButton: UIButton!    // IBOutlet은 화면과 연결되어있는 변수
    
    @IBAction func DoSomthing(_ sender: Any) {  // 화면과 연결되어 객체의 기능을 구현, 눌렀을 때에 여기가 실행
        
        testButton.backgroundColor = .orange        //타입 추론이 능할 경우 생략 가능. 누가 봐도 UIColor.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        // DetailVC class를 일반적인 방법으로 인스턴스화 시키면 클래스만 인스턴스화되고 화면은 안된다. 때문에 이런 방법으로 인스턴스화 시킴.
        
        self.present(detailVC, animated: true, completion: nil)
        
        
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad() // 화면이 올라갈 준비가 다 됐을 떄에 실행
        // Do any additional setup after loading the view.
  
    
        testButton.backgroundColor = UIColor.red
    
    
    }


}


