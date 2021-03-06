//
//  SetGame.swift
//  SetGame
//
//  Created by Nitai Halle on 05/05/2020.
//  Copyright © 2020 Nitai Halle. All rights reserved.
//

import Foundation
class SetGame
{
    private(set) var deckOfCards = [Card]()
    private(set) var cardsOnTheTable = [Card]()
    private let identityOptions = 3
    private let requestForNewCards = 3
    private let numberOfCardsAtFirst = 12
    
    init() {
        reset()
    }
    
    func reset(){
        deckOfCards.removeAll()
        cardsOnTheTable.removeAll()
        for shape in 0..<identityOptions{
              for color in 0..<identityOptions{
                  for fill in 0..<identityOptions{
                      for numberOfShapes in 0..<identityOptions{
                          let card = Card(shape: shape, color: color, filler: fill, numberOfShapes: numberOfShapes)
                          deckOfCards.append(card)
                      }
                  }
              }
          }
        
          deckOfCards.shuffle()
          for index in 0..<numberOfCardsAtFirst{
              cardsOnTheTable.append(deckOfCards.remove(at: index))
          }
    }
    
    func selected(at index : Int){
        cardsOnTheTable[index].isSelect = !cardsOnTheTable[index].isSelect
        let selectedCards = cardsOnTheTable.filter({$0.isSelect})
        if selectedCards.count == 3{
            checkMatch(on : selectedCards)
        }
    }

    private func checkMatch(on  selctedCards : [Card]){
        var colorsIdentity = [Int]()
        var shapesIdentity = [Int]()
        var numbersOfShapes = [Int]()
        var fillersIdentity = [Int]()
        
        for index in 0..<selctedCards.count{
            colorsIdentity += [selctedCards[index].colorIdentity]
            shapesIdentity.append(selctedCards[index].shapeIdentity)
            numbersOfShapes.append(selctedCards[index].numberOfShapes)
            fillersIdentity.append(selctedCards[index].fillerIdentity)
        }
        
        if match(on: colorsIdentity),match(on: shapesIdentity),match(on: numbersOfShapes),match(on: fillersIdentity){
            cardsOnTheTable = cardsOnTheTable.filter{$0.isSelect != true}
        }
        //It seems unnecessary to me
        for index in 0..<cardsOnTheTable.count{
            cardsOnTheTable[index].isSelect = false
        }
    }
    private func match(on selectedSequence : [Int]) -> Bool{
        let numberOfUniqe = selectedSequence.unique.count
        return (numberOfUniqe == 1 || numberOfUniqe == identityOptions) ? true : false
    }
    
    //need to update tableCardsToIndex for new cards
    func needMoreCards(){
        if !deckOfCards.isEmpty{
            if deckOfCards.count >= requestForNewCards {
                cardsOnTheTable.append(contentsOf: deckOfCards[0..<requestForNewCards])
                deckOfCards.removeSubrange(0..<requestForNewCards)
            } else {
                //not realy need it becouse 81 % 3 = 0
                cardsOnTheTable.append(contentsOf: deckOfCards[0..<deckOfCards.count])
                deckOfCards.removeSubrange(0..<deckOfCards.count)
            }
        }
    }
}
extension Array where Element : Hashable{
    var unique: [Element] {return Array(Set(self))}
}
