import UIKit

// Initializer
// 생성자
// init : 프로퍼티 생성 시에 초기값을 설정 안할 때에 사용.

class MyInfo {
    var name: String
    let myId: String
    var age: Int?
    var isAdult: Bool
    
    // designated initializer
    init(n: String, id: String) {
        self.name = n
        self.myId = id
        self.isAdult = ((age ?? 0) > 19) ? true : false
    }
    
 //   init(id: String) {              // init을 여러개 사용할 수도 있음.
 //       self.name = ""
 //       self.myId = id
 //      self.isAdult = (age > 19) ? true : false
 //   }
    
    // convenience initializer : 필수 조건 - 다른 init를 반드시 실행해야 한다.
    // init 마다 같은 로직을 실행할 때에, 기존의 init을 가지고 분기를 만들어 실행.
    // 위의 예에서는 isAdult의 로직을 공유.

    convenience init(id: String) {
        self.init(n: "", id: id)            //   반드시 실행해야 하는 init
    }
}

var myInfo1 = MyInfo(n: "kim", id: "abcd")  // 괄호는 init을 호출할 것이라고 표현하는 것. init이 생략됨.
var myInfo2 = MyInfo(id : "dkdk")           //  요 경우 두번째 init을 호출

myInfo1.myId
myInfo1.name

myInfo2.myId


struct MyConfig {
    var conf: String
    
}

// structure일 때 초기값 없이 생성할 수 있으나 호출할 때에 init을 설정하도록 자동으로 뜸.
// class는 프로퍼티가 옵셔널이 아닌이상 초기값을 꼭 설정해야함.
// convenience init을 언제 사용하면 좋은지 생각해보기.
