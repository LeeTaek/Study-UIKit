//
//  Town.swift.swift
//  MonsterTown
//
//  Created by 이택성 on 2021/11/25.
//

import Foundation

struct Town{
    var population = 21
    var numberOfStoplights = 4
    
    func printDescription() {               // 전역함수(특정 타입을 정의하는 함수가 아님)
        print("Population: \(population); number of stoplights: \(numberOfStoplights)")
    }
    
    mutating func changePopulation(by amount : Int) {       // 구조체 인스턴스를 구조체 프로퍼티가 변경하려면 mutating이 필요.
        if population >= 10 {
        population += amount
        } else {
            population = 0
        }
    }
}
