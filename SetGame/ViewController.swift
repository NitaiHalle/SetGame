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
    var shapes = ["▲","●","■"]
    let colors = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)]
    let fillers : [CGFloat] = [0,0.35,1] // for alpha component
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewFromModel()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var cardsButton: [UIButton]!
    
    @IBAction func selectedButton(_ sender: UIButton) {
        let cardNumber = cardsButton.firstIndex(of: sender)!
        if cardNumber < game.cardsOnTheTable.count{
            game.selected(at: cardNumber)
        }
        ViewFromModel()
    }
    @IBAction func threeMoreCards() {
        assert(game.cardsOnTheTable.count < cardsButton.count,"no have room for more cards")
        game.needMoreCards()
        ViewFromModel()
    }
    @IBAction func newGameButton(_ sender: Any) {
        game.reset()
        ViewFromModel()
    }
    
    @IBOutlet weak var threeMoreCardsButton: UIButton!
    
    @IBOutlet weak var numberOfCardsInStack: UILabel!
    
    private func ViewFromModel(){
        cardsViewFromModel()
        numberOfCardsInStack.text = "The number of cards in the stack: \(game.deckOfCards.count)"
        if game.deckOfCards.count >= 0, game.cardsOnTheTable.count < cardsButton.count{
            threeMoreCardsButton.isEnabled = true
        } else {
            threeMoreCardsButton.isEnabled = false
        }
    }
    
    private func cardsViewFromModel(){ 
        let cards = game.cardsOnTheTable
        for index in 0..<cardsButton.count{
            let button = cardsButton[index]
            if index < cards.count {
                let card = cards[index]
                button.setAttributedTitle(represent(for: card) , for: UIControl.State.normal)
                button.layer.borderWidth = 6
                button.layer.cornerRadius = 8.0
                button.layer.borderColor = card.isSelect ? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1):#colorLiteral(red: 0.9861351848, green: 1, blue: 0, alpha: 0)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
        let attributes : [NSAttributedString.Key : Any] = [.strokeColor : colors[card.colorIdentity],
                                                           .strokeWidth : -4,
                                                           .foregroundColor : colors[card.colorIdentity].withAlphaComponent(fillers[card.fillerIdentity])]
        var str = ""
        for _ in 0...card.numberOfShapes{
             str += shapes[card.shapeIdentity]
        }
        return NSAttributedString(string : str, attributes: attributes)
    }
}
