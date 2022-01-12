//
//  main.swift
//  MonsterTown
//
//  Created by 이택성 on 2021/11/25.
//

import Foundation

var myTown = Town()
//myTown.changePopulation(by: 500)
//myTown.printDescription()

//let genericMonst = Monster()
//genericMonst.town = myTown
//genericMonst.terrorizeTown()

let fredTheZombie = Vampire()
fredTheZombie.town = myTown
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()          // 언래핑.

fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()

fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()
