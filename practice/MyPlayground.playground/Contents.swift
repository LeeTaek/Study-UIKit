import UIKit

// Properties
// 프로퍼티
// : 변수의 개념, 어딘가에 들어있는 변수를 프로퍼티라고 부른다.
    
    

class MyInfo {
    
    // stored property ( 값을 저장할 수 있는 프로퍼티 )
    var name = ""
    var age = 0
    
    // lazy stored property ( 분산효과. 큰 변수를 한번에 많은 것들을 메모리에 띄울때 버벅거릴 수 있음,
    // 때문에 바로 사용할 것이 아니라면 lazy를 붙여 설정한다. 이 프로퍼티는 사용할 때에 메모리에 띄운다.)
    lazy var myProfiles = [UIImage(named: "n"), UIImage(named: "a"), UIImage(named: "c")]
    
    
    // computed property ( 계산 )
    // 형식 - 변수 선언: 타입 {클로져}
    var isAdult: Bool{
        if age > 19 {
            return true
        }
        return false
    }
    
    // computed property 예시
    // email을 보안을 위해 암호화 된 것으로 사용한다. (항상)
    var _email = ""                 //  암호화 된 값을 받기 위한 프로퍼티
    var email: String {
        get{                    //   받은 값을 사용
            return _email
        }
        set{
            _email = newValue.hash.description        // 값이 들어오는걸 set으로 받을 때에, newValue로 받도록 지정되어있음.
        }
    }
}

let myInfo = MyInfo()
myInfo.email = "abc@test.com"

myInfo.email

myInfo.age = 10
myInfo.name = "kim"
myInfo.isAdult

print(myInfo.age)



// 결론, 모든 proferty는 set은 안써도 get은 꼭 쓰인다.
// 변수에 항상 추가적인 logic을 저장할 때에 computed property를 사용하면 유익.
// 왜 stroed property와 computed propery를 사용하는지 생각해보기


4005455
