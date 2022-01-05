import UIKit
import Foundation

// Higher order function
// 고차 함수

let names = ["kim", "lee", "min", "john"]


// map -> 이미 있는 값을 어떻게 추가하여 표현할지? ex. kim님 등
let names2 = names.map { $0 + "님"}
names2

let names3 = names.map{ name in
    name.count
}
let names4 = names.map{ name in
    name.count > 3
}

// filter -> 걸러서 필요한 것만 추출.
let filterNames = names.filter{ (name) -> Bool in
    name.count > 3
}
filterNames

// reduce -> 하나로 뭉친다, 통합, 합친다
let sumNames = names.reduce("aaa") { $0 + $1 }
sumNames

let numberArr = [1, 2, 3, nil, 4, 5, nil]
let sumNum = numberArr.reduce(0) {$0 + ($1 ?? 0) }      //   nil일 경우 인자를 못쓰기 때문에 옵셔널을 통해 0으로 대체. 또는 compactMap
sumNum
    
// compactMap         : 안에 있는 nil값을 없앰.
let numbers = numberArr.compactMap { $0 }           // compactMap은 nil 값을 없앰
numbers

// flatmap   : 다차원 배열을 한단계씩 꺼내서 하나의 depth로 flat하게 꺼낼때.
let numbers2 = [[1,2,3], [4,5,6]]
let flatNum = numbers2.flatMap { $0 }
flatNum


