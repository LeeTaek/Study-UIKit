//
//  ViewController.swift
//  Passing Data (데이터를 넘겨주는 방법)
//  6가지 정도

// 1. instance property : 해당되는 property에 직접 써서 사용. 기본적이고 많이 사용하는 형태. 그러나 앱의 라이프 사이클을 고려 안하고 사용할 경우 크래시가 날 확률이 있다.
// 2. segueway : 여러개의 뷰 컨트롤러가 하나의 스토리보드에 있을 때에 사용.
// 3. instance를 통으로 넘겨줌 :  보통 스스로의 인스턴스를 넘겨줘 데이터를 mainVC로 가져올 때에.
// 4. delegate (delegation) pattern : 대리, 위임, 대신. 호출과 구현하는 것이 나뉘어져있음.
// 5. closure : 호출과 구현이 나뉘어져있음.
// 6. Notification : 호출과 구현이 나뉘어져있음. notification의 장점은 전혀 연결점이 없는 클래스 등에 데이터를 받거나 func를 호출하거나 할 때에 사용할 수 있음


import UIKit

class ViewController: UIViewController {
    // 6번 방법.
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let notificationName = Notification.Name("sendSomeString")
        // 중요한건 이름. 호출되면 저 이름의 기능이 구현된다는 소리.
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSomeString), name: notificationName, object: nil)
        //addObserver은 앱의 상태를 계속 감시
        //selector에는 notification의 정보를 받아올 수 있는 func이 들어감.
    }
    
    @objc func showSomeString(notification: Notification) {         // notification 정보를 받아옴. @objc는 런타임에 작동한다는 내용.
        if let str = notification.userInfo?["str"] as? String {     //  userInfo는 dictinary 형태로 존재. 키, 밸류. 키에 따른 밸류값을 가져옴.
            self.dataLabel.text = str
        }
    }
    
    @IBAction func moveToNoti(_ sender: Any) {
        
        let DetailVc = NotiDetailViewController(nibName: "NotiDetailViewController", bundle: nil)
        
        self.present(DetailVc, animated: true, completion: nil)
    }
    
    
    // 1번 방법
    @IBAction func moveToDetail(_ sender: Any) {
        
        let DetailVC = DetailVC(nibName: "DetailVC", bundle: nil)   // 인스턴스의
        
   //     DetailVC.someString = "aaa 스트링"         // 프로퍼티에 접근
        
   //     DetailVC.someLabel.text = "BB"  // 이 경우에는 크래시, 아직 present가 되지 않은 상태에서는 @IBOutlet, 즉 somelabel이 메모리에 올라가있지 않은 상태다.
        
        self.present(DetailVC, animated: true, completion: nil)
        
        DetailVC.someLabel.text = "BB"  // 즉 present가 실행된 후, 화면이 메모리에 올라가면 메모리에 접근 가능.
        
        // 이런 크래시를 방지하기 위해, DetailVC에 IBOutlet이 아닌 변수를 만들어 두고, DetailVC가 메모리에 올라가면 변수에 저장된걸 호출한다.
    }
    
    // 2번 방법
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //  segue버튼을 누르는 순간 실행되는 코드
    
        if segue.identifier == "segueDetail" {           //세그웨이의 아이디가 체크
            
            if let DetailVC = segue.destination as? SegueDetailViewController {
                              // detailVC가 SegueDtailVC로 타입 캐스팅이 되냐?
                
                DetailVC.dataString = "abcd"
            }
        }
    }
    
    // 3번 방법
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBAction func moveToInstance(_ sender: Any) {
        let DetailVC = InstanceViewViewController(nibName: "InstanceViewViewController", bundle: nil)
        
        DetailVC.mainVC = self              //  메인VC 자신을 연결해줌.
        
        self.present(DetailVC, animated: true, completion: nil)
        
    }

    // 4번 방법
    // 보내는 쪽, 받는 쪽 모두 설정이 필요하다.
    @IBAction func moveToDelegate(_ sender: Any) {
        
        let DetailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        
        DetailVC.delegate = self        // 밑의 extension이 없으면 protocol 규격을 지키지 못해 구현이 안된다, 또한 다른 데이터 접근 없이 protocol타입의 내용만 연결이 된다.
        
        self.present(DetailVC, animated: true, completion: nil)
    }
    
    //5번 방법
    // delegate처럼 호출과 구현 부분이 구분되어 있다.
    @IBAction func moveToClosure(_ sender: Any) {
        let DetailVC = ClosureDetailViewController(nibName: "ClosureDetailViewController", bundle: nil)
        
        DetailVC.myClosure = { str in  //파라미터를 in으로 구분
            // 구현부분
            self.dataLabel.text = str
        }
        self.present(DetailVC, animated: true, completion: nil)
    }
}

// 4. delegate를 이용해 데이터를 받을 때에, 프로토콜 지키는 것과 기능 구현을 extension을 통해 작성.
extension ViewController: DelegateDetailViewControllerDelegate {
    func passString(string: String){
        self.dataLabel.text = string
    }
}
