import UIKit



class UserInfo {
    var name = ""
    var age = 0
    func isAdult() -> Bool {                    // protocol과 다르게 class는 기능을 다 구현해두어야 한다.
        if age > 19 {
            return true
        }
        return false
    }
}

class Guest: UserInfo {
    override func isAdult() -> Bool {                   // 상속한 class의 기능을 guset class에서는 이걸로 작동
        return true
    }
    
    func present() {
        name = "kim"
        print(name)                                 // override가 없으니 super에 있는 걸 그대로 사용
        print(super.name)                           // super를 통해 부모 class의 변수에 접근할 수 있음
        print(super.isAdult())
        print(isAdult())
    }


let guest = Guest()
guest.present()
