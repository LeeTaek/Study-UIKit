import UIKit

// deInitializer
// 해제 : 메모리에 올리는걸 없애는 과정

var a: Int? = 10
a = nil                     // 메모리 해제


class Game {
    var score = 0
    var name = ""
    var round: Round?
    
    init() {
        print("game init")
    }
    deinit {                // 해제할 때에 뜨는 로직
        print("game deinit")
    }
}

class Round {
    weak var gameInfo: Game?
    var lastRound = 10
    var rountTime = 20
    deinit{
        print("round deinit")
    }
}

var game: Game? = Game()
var round: Round? = Round()

round?.gameInfo = game
game?.round = round

game = nil
round = nil
// 티가 안나는 실수. 그러나 없애야 하는 실수.
// 참조하는 인스턴스의 수(retain count)가 0이 될때 deinit이 된다.
// 다음과 같은 상호참조 상황에서는 deinit이 불가능. 변수가 없어지더라도 메모리에서는 절대 안없어짐.
// 이런 상황을 방지하기 위해선 참조하는 클래스의 관계를 생각해보자.
// Round는 Game에 굉장히 의존적인 class. Game없이는 Round가 있을 수 없다. 때문에 game을 참조할때 weak를 사용.
// weak는 retain count를 추가하지 않는다. 즉 game이 deinit 될 때 같이 없어진다는 것.
