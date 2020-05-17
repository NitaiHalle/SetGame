//
//  ViewController.swift
//  SetGame
//
//  Created by Nitai Halle on 05/05/2020.
//  Copyright © 2020 Nitai Halle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game = SetGame()
    var shapes = ["▲","●","■"] //TODO: change to dict
    let colors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)] //TODO: change to dict
    let colorsAndFillers = [[#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.3513484589),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)],[#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 0.3515625),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)],[#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.3520976027),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)]] //need to change it to more genric
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//    }

    @IBOutlet var cardsButton: [UIButton]!{
        didSet{
            cardsViewFromModel()
        }
    }
    
    @IBAction func selectedButton(_ sender: UIButton) {
        
        let cardNumber = cardsButton.firstIndex(of: sender)!
        
        if cardNumber < game.cardsOnTheTable.count{
            game.selected(at: cardNumber)
        }
        
        cardsViewFromModel()
        
    }
    
    
    @IBAction func threeMoreCards() {
        game.needMoreCards()
        cardsViewFromModel()
    }
    private var cardToButtonIndex = [Card : Int]()
    private var ButtonIndexToCard = [Int : Card]()
//    private func ButtonIndexToCard(at index : Int)-> Card {
//            if cardToButtonIndex[card] == nil{
//                 cardToButtonIndex[card] = freeButton.removeFirst()
//            }
//            return cardToButtonIndex[card]!
//        }
    
    private func cardsViewFromModel(){ //the source
        let cards = game.cardsOnTheTable
        for index in 0..<cardsButton.count{
            let button = cardsButton[index] //TODO: cardTOButtonIndex and ButtonIndexToCard dict
            if index < cards.count {
                let card = cards[index]
                button.setAttributedTitle(represent(for: card) , for: UIControl.State.normal)
                button.layer.borderWidth = 6
                button.layer.cornerRadius = 8.0
                button.layer.borderColor = card.isSelect ? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1):#colorLiteral(red: 0.9861351848, green: 1, blue: 0, alpha: 0)
                button.backgroundColor = card.isMatch ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//                if card.isMatch{
//                    button.setTitle("", for: UIControl.State.normal)
//                    button.setAttributedTitle(NSAttributedString(string: "") , for: UIControl.State.normal)
//                    //save button idx for next 3 cards..
//                    //freeButton.append(index)//
//                    indexWithCards.remove(at: index)//
//                }
            
            } else {
                //button with no card
                button.setTitle("", for: UIControl.State.normal)
                button.setAttributedTitle(NSAttributedString(string: "") , for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
        
    }
    
    private func represent(for card : Card) -> NSAttributedString{
        //let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : colors[card.colorIdentity]]
        let color = colorsAndFillers[card.colorIdentity]
        let attributes : [NSAttributedString.Key : Any] = [
                                                           .strokeColor : color[0],
                                                           .strokeWidth : -4,
        .foregroundColor : color[card.fillerIdentity]]
        var str = ""
        for _ in 0...card.numberOfShapes{
             str += shapes[card.shapeIdentity]
        }
        return NSAttributedString(string : str, attributes: attributes)
    }
    
    
//
//    private func cardsViewFromModel1(){
//        let cards = game.cardsOnTheTable
//        //var indexWithoutCards = Set(0..<cardsButton.count)//
//        for index in 0..<cards.count{
//            let card = cards[index]
//            let buttonIndex = cardToIndex(for: card)
//            print(buttonIndex)
//            freeButton.remove(buttonIndex)
//            let button = cardsButton[buttonIndex]
//          //  if indexWithCards.contains(index){ //index < cards.count {
//                //let card = cards[index]
//            button.setAttributedTitle(represent(for: card) , for: UIControl.State.normal)
//            button.layer.borderWidth = 6
//            button.layer.cornerRadius = 8.0
//            button.layer.borderColor = card.isSelect ? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1):#colorLiteral(red: 0.9861351848, green: 1, blue: 0, alpha: 0)
//            button.backgroundColor = card.isMatch ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            if card.isMatch{
//                button.setTitle("az", for: UIControl.State.normal)
//                button.setAttributedTitle(NSAttributedString(string: "") , for: UIControl.State.normal)
//                    //save button idx for next 3 cards..
//                freeButton.insert(buttonIndex)//.append(buttonIndex)//
//                    //
//              //  }
//            } else {
//                //button with no card
//                button.setTitle("", for: UIControl.State.normal)
//                button.setAttributedTitle(NSAttributedString(string: "") , for: UIControl.State.normal)
//              button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//                button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//            }
//        }
//    }
//
//    lazy var freeButton = Set(0..<cardsButton.count)
//    private var cardToIndex = [Card : Int]()
//    private func cardToIndex(for card : Card)-> Int {
//        if cardToIndex[card] == nil{
//             cardToIndex[card] = freeButton.removeFirst()
//        }
//        return cardToIndex[card]!
//    }
}
