import UIKit

// extension
//  기능 확장
// struct, class, enum, protocol 등에 사용 가능
// ex. 숫자(int) 짝수, 홀수인지에 따라 여러 구조에서 실행되야 함
extension Int {                 // Int라는 것에 기능 추가
    var oddOrEven: String{
        if self % 2 == 0 {
            return "짝수"
        }
        return "홀수"
    }
}
3.oddOrEven
4.oddOrEven

// UI의 color를 여러번 사용할 때에 사용.
// mainColor1 = xxx
// mainColor2 = xxx
extension UIColor {
    class var mainColor1: UIColor {         // 클래스 변수. 이를 참조할때 굳이 인스턴스화 안해도 된다.
        UIColor(red: 120/255, green: 70/255, blue: 120/255, alpha: 1)
    }
}

var button = UIButton()
 
button.titleLabel?.textColor = .mainColor1         // calss var로 선언했기 때문에 참조할때 클래스 인스턴스 안시켜도 됨.
// command + control 을 누르고 인스턴스를 클릭하면 참조하는 해당 파일을 확인할 수 있다.


