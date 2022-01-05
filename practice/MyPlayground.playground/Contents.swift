import UIKit

// protocol
// 규격, 규약, 규칙, 청사진, 뼈대
// 내가 구현해야 할 것들을 놓치지 않고 구현할 수 있다.
// protocol은 여러개 만들어 사용 가능.
// protocol은 초기값이 들어가면 안됨.
// 그런데 기본 값이 같다면 protocol이 아니라 class로 구현해서 상속할 수도 있음.

protocol UserInfo {
    var name: String { get set }             // get은 필수, set은 선택 사항
    var age: Int { get }                    //  set이 없으면 구현할 때에 set을 해도 되고 안해도 됨.그러나  let으로 구현하면 set이 불가능해 에러뜬다.
    func isAdult() -> Bool                   // 내용은 있으면 안됨.
}

extension UserInfo {                    // protocol에 기능을 넣으려면 extension을 가지고 구현할 수 있음.
    func isAdult() -> Bool {
        if age > 19 {
            return true
        }
        return false
    }
}

protocol UserScore {
    var score: Int { get set }
}

protocol UserDetailInfo: UserInfo, UserScore{           // 프로토콜을 같이 묶어서 사용 가능
}

class Guest: UserDetailInfo {
    var score: Int = 0
    // protocol을 준수해서 구현하겠다.
    var name: String = "kim"
    var age: Int = 0
}

class Member: UserInfo {
    var name: String
    var age: Int
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
}

class VIPMember: UserInfo {
    var name: String = "lee"
    var age: Int = 0
}

class UserInfoPresenter {
    func present() {
        let guest = Guest()
        let member = Member(name: "jane", age: 25)
        let vip = VIPMember()
        
        let members: [UserInfo] = [guest, member, vip]
        // members를 타입선언 없이 가져오면 멤버들의 타입이 다 다르기 때문에 배열로 만들 수 없다.
        // 그러나 protocol로 선언하면 배열로 묶을 수 있고, protocol에 해당하는 변수들만 참조할 수 있다.
        
        for element in members {
            print(element.name)
        }
        
    }
}

let presenter = UserInfoPresenter()
presenter.present()
