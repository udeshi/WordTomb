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
    
    //let tile1 : GameTile = GameTile(width: 100, height: 100)
    
    var gameQuestions=[Question]()
    var sugesstions=[Question]()
    var puzzleTiles=[GameTile]()
    var uniqueLetters = Set<Character>()
    var randomIndexes=[[String:Any]]()
    let TILE_WIDTH : CGFloat = 70
    let TILE_HEIGHT : CGFloat = 70
    let MAX_GRID_TILES = 10
    var gridMap = [[Int]]()
    var viewArray : [[UIView]] = []
    var puzzelStartX : CGFloat = -100
    var puzzelStartY : CGFloat = 450
    var letterStartX : CGFloat = -335
    var letterStartY : CGFloat = 450

    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.brown
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
          initiliaze()
          if (sugesstions.count > 0){
              creatGridArray()
              createViewArray()
//            loadTilesToGrid()
        //            loadQuestionsToTable()
         //width : 834.0
        //height : 1112.0
//            loadLettersToStackView()
        }
        loadAssets()
    }
    
    
    func navigateToScene(screenName: String) {
        if("Dashboard" == screenName) {
            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            let viewController = appDelegate.window!.rootViewController as! LoginViewController
            viewController.performSegue(withIdentifier: "DashboardNavigationController_Segue", sender: self)
            
        }
        
    }
    
    fileprivate func loadAssets() {
        //tile1.position = CGPoint(x: 0, y: 0)
        //tile1.zPosition = 100
        //addChild(tile1)
    }
    
    func initiliaze(){
        //let categoryType = UserDefaultsHandler().getData(key: "selectedCategoryId")
        // let selectedLevel = UserDefaultsHandler().getData(key: "selectedLevel")
        sugesstions = CoreDataHandler.fetchQuestions(level: Int(1), type: Int(1))
        if(sugesstions.count > 0){
            let randomIndex = Common().getRandomNumber(arrayCount: sugesstions.count)
            let question = sugesstions[randomIndex]
            print(question.answer)
            randomIndexes.append(["index" : 0, "letter" : Array(question.answer!)[0]])
            gameQuestions.append(question)
            sugesstions.remove(at: Int(randomIndex))
            getOtherQuestions(comparedWith: 0)
        }
    }
    
    private func getOtherQuestions(comparedWith: Int){
        var letters = Array((gameQuestions[comparedWith]).answer!)
        print("letters bef ", letters)
        let PreviousMatch = randomIndexes.last!["letter"] as! Character
        letters = letters.filter{$0 != PreviousMatch}
        print("letters af ", letters)
        insertToArray(letters: letters)
        var unLetters = Set<Character>()
        unLetters = unLetters.union(letters)
        let currentQuestionSize = gameQuestions.count
        for i in unLetters.indices{
            let matchedLetter = unLetters[i]
            print ("letter : ....." , unLetters[i])
            let compatibleQuestions = sugesstions.filter{
                ($0.answer?.contains(where: {$0==unLetters[i]}))!
            }
            if(compatibleQuestions.count>0){
                print("all com" , compatibleQuestions.count)
                let randomIndex = compatibleQuestions.count - 1 <= 0 ? 0 : Common().getRandomNumber(arrayCount: compatibleQuestions.count)
                getCompatibleQuestions(compatibleQuestions: compatibleQuestions, randomIndex: randomIndex, matchedLetter:matchedLetter)
                print ("new count : " , gameQuestions.count)
                if (currentQuestionSize + 1 == gameQuestions.count){
                    break;
                }
            }
        }
        if(sugesstions.count>0 && gameQuestions.count < 5 && currentQuestionSize + 1 == gameQuestions.count){
            getOtherQuestions(comparedWith: gameQuestions.count - 1)
        }
    }
    
    fileprivate func getCompatibleQuestions(compatibleQuestions: [Question],randomIndex: Int, matchedLetter: Character){
        let question = compatibleQuestions[randomIndex]
        var startingIndex=0
        let index = Array(question.answer!).index(of:matchedLetter)
        if(randomIndexes.count-1>0){
            // get starting index
            var previousIndex =  randomIndexes.last
            //let preMatchedLetter = previousIndex!["letter"] as! Character
            
            let parentIndex = randomIndexes[randomIndexes.count-1]["index"] as! Int>0 ?randomIndexes[randomIndexes.count-1]["index"] as! Int : 0
            startingIndex = parentIndex - index!
        }else{
            let previousLettersLength = index! - 0
            print("previousLettersLength", previousLettersLength)
            randomIndexes[randomIndexes.count - 1]["index"] = previousLettersLength
            
        }
        
        if(MAX_GRID_TILES >= Array(question.answer!).count + startingIndex && startingIndex >= 0){
            randomIndexes.append(["index" : randomIndex, "letter" : matchedLetter])
            print(question.answer)
            gameQuestions.append(question)
            print("sugg before", sugesstions.count)
            sugesstions = sugesstions.filter{$0.id != question.id}
            print("sugg after", sugesstions.count)
        }
        else{
            var compatibleQuestionsCopy = compatibleQuestions
            print("compatibleQuestionsCopy before", compatibleQuestionsCopy.count)
            compatibleQuestionsCopy = compatibleQuestionsCopy.filter{$0.id != question.id}
            print("compatibleQuestionsCopy aft", compatibleQuestionsCopy.count)
            if(compatibleQuestionsCopy.count>0 ){
                let randIndex = compatibleQuestionsCopy.count - 1 <= 0 ? 0 : Common().getRandomNumber(arrayCount: compatibleQuestionsCopy.count)
                print("mmmmmmmmmm")
                getCompatibleQuestions(compatibleQuestions: compatibleQuestionsCopy, randomIndex: randIndex, matchedLetter: matchedLetter)
            }
        }
    }
    
    fileprivate func creatGridArray(){
        let maxGridVal = gameQuestions.max{($0.answer!.count < $1.answer!.count)}
        _ = (maxGridVal?.answer?.count)! + 1
        gridMap = Array(repeating: Array(repeating:0, count: MAX_GRID_TILES),count:MAX_GRID_TILES)
        for questionIndex in 0...gameQuestions.count-1{
            let randIndex = randomIndexes[questionIndex]["index"] as! Int
            var startingIndex = 0
            if(questionIndex-1>0){
                // get starting index
                var previousIndex =  randomIndexes[questionIndex]
                let matchedLetter = previousIndex["letter"] as! Character
                let index = Array(gameQuestions[questionIndex].answer!).index(of:matchedLetter)
                let parentIndex = randomIndexes[questionIndex-2]["index"] as! Int>0 ?randomIndexes[questionIndex-2]["index"] as! Int : 0
                startingIndex = parentIndex - index!
                
            }
            print(gameQuestions[questionIndex].answer!)
            if(questionIndex%2==0){
                print("even",gameQuestions[questionIndex].answer)
                for x in startingIndex...Array(gameQuestions[questionIndex].answer!).count-1{
                    //gridMap[questionIndex].insert(1, at: x)
                    gridMap[randIndex][x] = 1
                }
                print("=====================")
                print(gridMap)
            }else{
                //startingIndex=startingIndex+1
                print("odd",gameQuestions[questionIndex].answer!)
                for i in startingIndex...Array(gameQuestions[questionIndex].answer!).count-1{
                    // for x in 0...Array(gameQuestions[questionIndex].answer!).count-1{
                    gridMap[i][startingIndex+1] = 1
                    // }
                    
                }
                print("=====================")
                print(gridMap)
            }
        }
        
        
    }
    
    fileprivate func insertToArray(letters: [Character]){
        //        for i in 0...letters.count-1{
        //            uniqueLetters.insert(letters[i])
        uniqueLetters = uniqueLetters.union(letters)
        print(uniqueLetters)
        // }
    }
    
    fileprivate func createViewArray() {
        for r in gridMap {
            for c in r {
                let tile = getTile(forNumber: c)
                puzzelStartX = puzzelStartX+110
                
                addChild(tile)
            }
            //print("x ",puzzelStartX," ================ y ",puzzelStartY)
            puzzelStartY = puzzelStartY-110
            puzzelStartX = -100
        }
       
    }
    
    fileprivate func getTile(forNumber number : Int) -> GameTile {
        let tile = GameTile(width: 100, height: 100, x:puzzelStartX, y:puzzelStartY)
        tile.position = CGPoint(x: puzzelStartX , y: puzzelStartY)
        tile.zPosition = 100
        
        if number == 0 {
            tile.bodrderColor = UIColor.clear
            tile.fillColor = UIColor.clear
        }else{
            puzzleTiles.append(tile)
            print(puzzelStartX,"=============== y ",puzzelStartY)
        }
        
        return tile
    }
    
    fileprivate func loadLetters(){
        
    }
}
