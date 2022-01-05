import UIKit

// generic <Type 내가 정한 임의의 타입>
// logic을 반복해서 쓰고 싶은 경우에는 func을 이용.
// type을 여러가지를 반복해서 쓰고 싶은 경우 generic을 이용

// stack
struct MyStack<MyType> where MyType: Numeric {                // type은 임의로 아무거나 써도 됨.
    // where의 타입을 제한할 수 있음. 숫자의 경우 Numeric, 문자의 경우 StringProtocol
    // where의 경우 내가 만든 타입을 그 스타일 안에서만 사용하고 싶은 경우사용함.

    var items = [MyType]()
    
    mutating func push(item: MyType) {              // struct 안에서 스스로 변하고 싶은 경우 self가 mutating 사용
        items.append(item)
    }
    
    mutating func pop() -> MyType? {
        if items.isEmpty {
            return nil
        }
        return items.removeLast()
    }
}

var myStack = MyStack<String>()

myStack.push(item: "4")

var myStack2 = MyStack<Int>()
myStack2.push(item: 5)
myStack2.push(item: 6)

myStack2.pop()
myStack2.pop()
myStack.pop()

// queue
