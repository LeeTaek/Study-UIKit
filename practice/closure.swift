//
//  closure.swift
//  Swift
//
//  Created by 이택성 on 2021/09/14.
//

import Foundation
import Swift

// 코드의 블럭
// 일급 시민
// 변수, 상수 등으로 저장, 전달 인자로 전달이 가능
// 함수 : 이름이 있는 클로저

// { (매개변수 목록) -> 반환 타입 in
//      실행 코드
// }

// 함수를 사용한다면

func sumFunction(a: Int, b: Int) -> Int {
    return a + b
}

var sumResult: Int = sumFunction(a: 1, b: 2)

print (sumResult)       // 3


// 클로저를 사용한다면
var sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a + b
    
}

sumResult = sum(1, 2)
print(sumResult) // 3

// 함수는 클롲의 일종이므로
// sum 변수에는 당연히 함수도 할당할 수 있다.

sum = sumFunction(a:b:)
sumResult = sum(1, 2)
print(sumResult) // 3
 

// 클로저는 보통 함수의 전달인자로 많이 사용이 됨

let add: (Int, Int) -> Int
add = { (a: Int, b: Int) -> Int in
    return a + b
}

let substract: (Int, Int) -> Int
substract = { (a: Int, b: Int) -> Int in
    return a - b
}

let devide: (Int, Int) -> Int
devide = { (a: Int, b: Int ) -> Int in
    return a / b
}

func calculate(a: Int, b:Int, method: (Int, Int) -> Int) -> Int{
    return method(a, b)
}
 
var calculated: Int

calculated = calculate(a: 50, b: 10, method: add)
print(calculated) // 60

calculated = calculate(a: 50, b: 10, method: substract)
print(calculated) // 4

calculated = calculate(a: 50, b: 10, method: devide)
print(calculated) // 5

calculated = calculate(a: 50, b: 10, method: { (left: Int, right: Int) -> Int in
    return left * right
})

print (calculated) // 500



// 후행 클로저 (메서드 생략 가능)
// 클로저가 함수의 마지막 전달인자라면
// 마지막 매개변수 이름을 생략한 후
// 함수 소괄호 외부에 클로저를 구현할 수 있다.

result = calculate(a: 10, b: 10) {left: Int, right: Int) -> Int in
    return left + right
}

print(result) // 20


// 변환타입 생략 (메서드의 타입 생략 가능)
// calculate 함수의 method 매개변수는
// Int 타입을 반환할 것이라는 사실을 컴파일러도 아릭 떄문에
// 굳이 클로저에서 반환타입을 명시해주지 않아도 됩니다.
// 대신 in 키어드는 생략 불가

result = calculate(a: 10, b: 10, method: { (left: Int, right Int) in
    return left + right
}

print(result) // 20

result = calculate(a: 10, b: 10) { (left: Int, right: Int) in
    return left + right
}

// 단축 인자이름 (method의 매개변수 생략 가능)
// 클로저의 매개변수 이름이 굳이 불필요하다면 단속 인자 이름을 활용할 수 있다.
// 단축인자 이름은 클로저의 매개변수 순서대로 $0, $1... 처럼 표현

result = calculate(a: 10, b: 10, method: {
    return $0 + $1
})

print(result) // 20


// 암시적 반환 표현 (메서드의 리턴 생략 가능)
// 클로저가 반환하는 값이 있다면
// 클로저의 마지막 줄의 결과 값은 암시적으로 반환값으로 취급한다.

result = calculate(a: 10, b: 10) { $0 + $1 }

print(result) // 20
