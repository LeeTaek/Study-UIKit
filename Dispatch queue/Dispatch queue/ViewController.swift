//
//  ViewController.swift
//  Dispatch Queue :  Thread를 여러개 만들어서 관리.
//
//  Created by 이택성 on 2022/01/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLable: UILabel!
    
    
    @IBOutlet weak var finishLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            self.timerLable.text = Date().timeIntervalSince1970.description
        }
    }

    @IBAction func action1(_ sender: Any) {
        DispatchQueue.main.async {
            // 요렇게도 가능
            // main thread 는 사용자에게 끊임없이 갱신되는 UI등이 올려져야 한다.
                self.finishLable.text = "끝"
        }
    }
    func simpleClosure(completion: @escaping() -> Void) {
        
        DispatchQueue.global().async {  // global은 보통 background에서 작업된다고 표현하기도 함..
            
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
                completion()
        }
    }
    
    @IBAction func action2(_ sender: Any) {
        // 여러개의 thread
        // queue를 costom하게 만든다고 표현하기도 함.
        let dispatchGroup = DispatchGroup()
        
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")

        queue1.async(group: dispatchGroup, qos: DispatchQoS.background) {
            // dispatchQos : 우선순위
            // background나 utility는 우선순위가 낮음.
            // 시간과 상관 없이 실행 되기만 하면 되는 작업을 보통 background에 넣음
            // default 는 기본
            // userInteractive 는 우선순위가 가장 높은 작업.
            // 바로 유저가 결과를 확인할 수 있는 작업.
            
            dispatchGroup.enter()
            
            DispatchQueue.global().async {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave() // 끝
            }
        }
        // dispatch queue의 경우 안의 logic이 끝날때 까지 thread가 끝나지 않는다.
        // 그런데 안에 다시 async로 thread를 만들 경우 logic이 진행되든 말든 queue1을 진행하며 넘어간다.
        // 이미지 해상도를 받아오거나, 네트워크 반응을 기다리는 경우 작업을 처리하느라 lock이 걸리지 않게 이런 식으로 구성한다.
        
        queue2.async(group: dispatchGroup, qos: .userInteractive) {
            dispatchGroup.enter()   // 시작
            DispatchQueue.global().async {
                for index in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave() // 끝
            }
        }
        // 이 경우를 막기 위해 dispathGroup에는 작업이 진행중인 것과 끝내는 것을 알려주는 기능이 있다.
        // leave()가 누락될 경우 작업이 계속 진행되는 걸로 인식해 무한대기 탈 수 있다.
        
        queue3.async(group: dispatchGroup) {
            dispatchGroup.enter()   // 시작
            DispatchQueue.global().async {
                for index in 20..<30 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave() // 끝
            }

        }
        // async는 실행하고 logic이 진행되던 말던 바로 다음 logic을 실행
        // 그러나 다음의 경우 순차적으로 코드 실행. sync로 작동
        // 왜냐하면 작업자가 queue1 하나이기 때문.
        // 이런 작업을 원하는 경우 thread가 더 필요.
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }
        //   notify는 진행할 작업이 없을 때에 실행됨.
    }
    
    
    
    @IBAction func action3(_ sender: Any) {
        
//        DispatchQueue.main.sync {
//            print("main sync")
//        }
        // 때문에 main thread에서 sync를 쓸일은 없다.
        // main thread는 작업이 안끝나기 때문에 계속 기다리는 상태. deadlock이 생긴다.
        
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        

        queue1.sync {
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
        
        queue2.sync {
            for index in 10..<20 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
      // 이러한 특성으로, 자기의 thread 안에서 자신에게 작업을 할당하면 deadlock이 걸림

       
        // sync는 다른 thread를 다 멈춤. 자신의 작업을 진행할 때가지 기다리게 만듬.
        // 굉장히 중요한 작업이어서, 이 작업이 진행되는 동안 다른 작업들이 절대 실행되면 안될 때 sync로 작업함.
        // 예를 들면 금융권 잔액 관리 등. threa safe한 상황에서 쓰임.
        // 최근에는 sync 대신 async를 사용하는 추세이기 때문에 백엔드가 아닌 이상 잘 안쓰임.
        
    
    }ㄱ
}
