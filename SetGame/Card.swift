//
//  Card.swift
//  SetGame
//
//  Created by Nitai Halle on 05/05/2020.
//  Copyright © 2020 Nitai Halle. All rights reserved.
//

import Foundation
struct Card : Hashable{
    var isMatch = false
    var isSelect = false
    var shapeIdentity : Int
    var colorIdentity : Int
    var fillerIdentity : Int
    var numberOfShapes : Int
    
    init(shape: Int, color : Int, filler:Int, numberOfShapes : Int) {
        self.shapeIdentity = shape
        self.colorIdentity = color
        self.fillerIdentity = filler
        self.numberOfShapes = numberOfShapes
        
    }
    func Hash(into hasher: inout Hasher){
        hasher.combine(shapeIdentity)
        hasher.combine(colorIdentity)
        hasher.combine(fillerIdentity)
        hasher.combine(numberOfShapes)
    }
    
}

