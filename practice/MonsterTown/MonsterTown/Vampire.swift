//
//  Vampire.swift
//  MonsterTown
//
//  Created by 이택성 on 2021/11/25.
//

import Foundation

class Vampire: Monster {
    var numberOfVampire = 1
    var VamprireArr: [String] = ["Vampire 1"]
    
    final override func terrorizeTown() {
        town?.changePopulation(by: -1)
        if town != nil {
            numberOfVampire += 1
            VamprireArr.append("Vamprie \(numberOfVampire)")
        }
        super.terrorizeTown()
        print("number Of Vampire: \(numberOfVampire)" )
        print(VamprireArr.description)
    }
}
