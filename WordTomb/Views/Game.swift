//
//  Game.swift
//  WordTomb
//
//  Created by Udeshi on 5/13/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit

class Game: UIView {
  var sceneNavigator : SceneNavigator?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var gameQuestions=[Question]()
    override func awakeFromNib() {
        super.awakeFromNib()
        initiliaze()
    }
    
    func initiliaze(){
    var questions = CoreDataHandler.fetchQuestions(level: 1)
    let randomIndex = Common().getRandomNumber(arrayCount: questions.count)
    gameQuestions.append(questions[randomIndex])
    questions.remove(at: Int(randomIndex))
    getOtherQuestions(questions: questions, comparedWith: 0)
    }
    
    private func getOtherQuestions(questions: [Question], comparedWith: Int){
        let letters = (gameQuestions[comparedWith]).answer?.components(separatedBy: "")
        let randomIndex = Common().getRandomNumber(arrayCount: (letters?.count)!)
        let compatibleQuestions = gameQuestions.filter{
            ($0.answer?.localizedCaseInsensitiveContains(letters![randomIndex]))!
        }
        gameQuestions.append(compatibleQuestions[Common().getRandomNumber(arrayCount: compatibleQuestions.count)])
        print(gameQuestions)
        getOtherQuestions(questions: questions, comparedWith: gameQuestions.count - 1)
        
    }
    
}
