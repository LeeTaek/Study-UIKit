//
//  valueReferenceType.swift
//  Swift
//  값과 참조 타입
//  Created by 이택성 on 2021/09/14.
//

import Foundation
import Swift

struct ValueType {
    var property = 1
}

class ReferenceType {
    var property = 1
}

let firstStructInstance = ValueType()
var secondStructInstance = firstStructInstance
secondStructInstance.property = 2

print("firstStructInstance.property = \(firstStructInstance.property)") // 1
print("secondStructInstance.property = \(secondStructInstance.property)") // 2


let firstClassReference = ReferenceType()
var secondClassReference = firstStructInstance
secondClassReference.property = 2

print("firstClassReference.property = \(firstClassReference.property)") // 2
print("secondClassReference.property = \(secondClassReference.property)") // 2
