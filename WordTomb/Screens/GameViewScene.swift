//
//  GameSceen.swift
//  WordTomb
//
//  Created by Udeshi on 5/13/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import SpriteKit

class GameViewScene: SKScene,SceneNavigator {
    var gameQuestions=[Question]()
    override func didMove(to view: SKView) {
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
    
    func navigateToScene(screenName: String) {
        if("Dashboard" == screenName) {
            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            let viewController = appDelegate.window!.rootViewController as! LoginViewController
            viewController.performSegue(withIdentifier: "DashboardNavigationController_Segue", sender: self)
            
        }
        
    }
}
