//
//  main.swift
//  1371
//
//  Created by 이택성 on 2022/01/17.
//

import Foundation

var text = ""
var dic = [String.Element : Int]()
var alphavet = "abcdefghijklnmopqrstuvwxyz".map{$0}

while let inputStr = readLine() {
    text += inputStr
}

for char in text {
    if char.isLetter {
      dic[char] =  dic[char] == nil ? 1 : dic[char]! + 1
    }
}

var maxNum = dic.values.max()

for i in alphavet {
    if dic[i] == maxNum {
        print(i, terminator: "")
    }
}
