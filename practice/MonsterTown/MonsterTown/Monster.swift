//
//  Monster.swift
//  MonsterTown
//
//  Created by 이택성 on 2021/11/25.
//

import Foundation

class Monster{
    var town: Town?
    var name = "Monster"
    
    func terrorizeTown() {
        if town != nil{
            print("\(name) is terrorizing a town!")
        }else {
            print("\(name) hasn't found a town to terrorize yet")
        }
    }
}
