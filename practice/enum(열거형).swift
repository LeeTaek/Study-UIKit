//
//  practice.swift
//  Swift
//
//  Created by 이택성 on 2021/09/14.
//

import Swift

//열거형은 타입이므로 대문자 카멜케이스를 이용해 정의
//각 case는 소문자 카멜 케이스롲 ㅓㅇ의
//각 case는 그 자체가 고유의 값



enum Weekday {
    case mon
    case tue
    case Wed
    case thu, fri, sat, sun
}

var day: Weekday = Weekday.mon
day = .tue

print(day)


// 케이스 사용의 경우, 열거형의 목록 중에 하나라도 빼먹으면 오류
switch day {
case .mon, .tue, .wed, .thu:
    print("평일입니다")
case Weekday.fri:
    print("불금파티!!")
case .sat, .sun:
    print("신나는 주말! ")
}

// C언어의 enum처럼 정수값을 가질 수도 있다.
// rawValue를 사용하면 됨
// case 별로 각각 다른 값을 가져야 함
// 그러나 String형에 원시값을 지정 안한 경우, 그 case이름을 그대로 가져옴.

enum Fruit: Int {
    case apple = 0
    case grape = 1  //  Int형의 경우 자동으로 1씩 증가, 즉 =1을 지워도 grape는 1
    case peach
    
}


print("Fruit.peach.rawValue == \(Fruit.peach.rawValue)")


// 원시값을 통한 초기화
// rawValue를 통해 초기화 가능
// rawValue에 해당하는 case가 존재하지 않을 수 있응므로
// rawValue를 통한 초기화 한 인스턴스는 옵셔널 타입이다.

// let apple.Fruit = Fruit(rawValue: 0)
let apple.Fruit? = Fruit(rawValue: 0)

if let orange: Fruit = Fruit(rawValue: 5) {
    print("rawValue 5에 해당하는 케이스는 \(orange) 입니다")
} else {
    print("rawValue 5에 해당하는 케이스가 없습니다")
}


// 열거형에 메서드도 추가 가능

enum Month {
    case dec, jan, feb
    case mar, apr, may
    case jun, jul, aug
    case sep, oct, nov
    
    func printMessage() {
        switch self {
        case .mar, .jan, .aug:
            print("따스한 봄")
        case .mar, .apr, .may:
            print("여름 더워")
        case .sep, .oct, .nov:
            print("독서의 계절")
        case .dec, .jan, .fab:
            print("추워")
    
        }
    }
}

Month.mar.printMessage()
