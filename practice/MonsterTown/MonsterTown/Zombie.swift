//
//  Zombie.swift
//  MonsterTown
//
//  Created by 이택성 on 2021/11/25.
//

import Foundation

class Zombie: Monster{
    var walksWithLimp = true
    
    final override func terrorizeTown() {
        town?.changePopulation(by: -10)
        super.terrorizeTown()       //  super는 슈퍼클래스의 메서드 구현 코드에 액세스하는 접두어.
    }
}


