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
    @IBOutlet weak var gridContainerView: UIView!
    
    var gameQuestions=[Question]()
    var uniqueLetters = Set<Character>()
    var randomIndexes=[[String:Any]]()
    let TILE_WIDTH : CGFloat = 100
    let TILE_HEIGHT : CGFloat = 100
    let MAX_GRID_TILES = 10
    var gridMap = [[Int]]()
    let tempDataAray = [[0,1,1,1,0],[1,1,1,0,0],[0,0,0,1,0],[1,0,1,0,1],[0,1,0,1,0]]
    var viewArray : [[UIView]] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initiliaze()
        creatGridArray()
        createViewArray()
        loadTilesToGrid()
    }
    
    func initiliaze(){
        var questions = CoreDataHandler.fetchQuestions(level: 1)
        let randomIndex = Common().getRandomNumber(arrayCount: questions.count)
        let question = questions[randomIndex]
        randomIndexes.append(["index" : 0, "letter" : Array(question.answer!)[0]])
        gameQuestions.append(question)
        questions.remove(at: Int(randomIndex))
        getOtherQuestions(questions: questions, comparedWith: 0)
    }
    
    private func getOtherQuestions(questions: [Question], comparedWith: Int){
        var questionCopy = questions
        let letters = Array((gameQuestions[comparedWith]).answer!)
        insertToArray(letters: letters)
        var randomIndex = Common().getRandomNumber(arrayCount: (letters.count))
        var matchedLetter = letters[randomIndex]
        let compatibleQuestions = questions.filter{
            ($0.answer?.contains(where: {$0==letters[randomIndex]}))!
        }
        if(compatibleQuestions.count>0){
            randomIndex = Common().getRandomNumber(arrayCount: compatibleQuestions.count)
            let question = getCompatibleQuestions(compatibleQuestions: compatibleQuestions, randomIndex: randomIndex, matchedLetter:matchedLetter)
            if(question != nil){
                gameQuestions.append(question!)
                questionCopy.remove(at: randomIndex)
                print(gameQuestions)
            }
           
        }
        if(questionCopy.count>0){
            getOtherQuestions(questions: questionCopy, comparedWith: gameQuestions.count - 1)
        }
    }
    
    fileprivate func getCompatibleQuestions(compatibleQuestions: [Question],randomIndex: Int, matchedLetter: Character) -> Question? {
        let question = compatibleQuestions[randomIndex]
        if(randomIndexes.count-1 > 0 && MAX_GRID_TILES > Array(question.answer!).count + (randomIndexes[randomIndexes.count-1]["index"] as! Int)){
                randomIndexes.append(["index" : randomIndex, "letter" : matchedLetter])
                return question
        }
        else if( randomIndexes.count-1 == 0 && MAX_GRID_TILES > Array(question.answer!).count + 0){
            randomIndexes.append(["index" : randomIndex, "letter" : matchedLetter])
            return question
        }
        else{
            var compatibleQuestionsCopy = compatibleQuestions
            compatibleQuestionsCopy.remove(at: randomIndex)
            let randIndex = Common().getRandomNumber(arrayCount: compatibleQuestions.count)
            if(compatibleQuestionsCopy.count>0){
                return getCompatibleQuestions(compatibleQuestions: compatibleQuestionsCopy, randomIndex: randIndex, matchedLetter: matchedLetter)
            }else{
                return nil
            }
        }
    }
    
    fileprivate func creatGridArray(){
        gridMap = Array(repeating: Array(repeating:0, count: MAX_GRID_TILES),count:MAX_GRID_TILES)
        for questionIndex in 0...gameQuestions.count{
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
            if(questionIndex%2==0){
                for x in startingIndex...Array(gameQuestions[questionIndex].answer!).count{
                    //gridMap[questionIndex].insert(1, at: x)
                    gridMap[randIndex].insert(1, at: x)
                }
                
            }else{
                for i in startingIndex...MAX_GRID_TILES{
                    for x in 0...Array(gameQuestions[questionIndex].answer!).count{
                        gridMap[i].insert(1, at: x)
                    }
                }
            }
        }
        print(gridMap)
        
    }
    
    fileprivate func insertToArray(letters: [Character]){
        for i in 1...letters.count{
            uniqueLetters.insert(letters[i])
        }
    }
    
    fileprivate func loadTilesToGrid() {
        var stacks : [UIStackView] = []
        for tiles in viewArray {
            let tilesStack = UIStackView(arrangedSubviews: tiles)
            tilesStack.translatesAutoresizingMaskIntoConstraints = false
            tilesStack.axis = .horizontal
            tilesStack.distribution = .fill
            tilesStack.spacing = 2
            stacks.append(tilesStack)
        }
        
        // main stack
        let mainStack = UIStackView(arrangedSubviews: stacks)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.distribution = .fill
        mainStack.spacing = 2
        gridContainerView.addSubview(mainStack)
        
        mainStack.centerXAnchor.constraint(equalTo: gridContainerView.centerXAnchor).isActive = true
        mainStack.centerYAnchor.constraint(equalTo: gridContainerView.centerYAnchor).isActive = true
        
    }
    
    fileprivate func createViewArray() {
        for r in gridMap {
            var tiles : [UIView] = []
            for c in r {
                let tile = getTile(forNumber: c)
                tiles.append(tile)
            }
            viewArray.append(tiles)
        }
    }
    
    fileprivate func getTile(forNumber number : Int) -> UIView {
        let view = UIView(frame: CGRect(x: -TILE_WIDTH/2, y: -TILE_HEIGHT/2, width: TILE_WIDTH, height: TILE_HEIGHT))
        view.heightAnchor.constraint(equalToConstant: TILE_HEIGHT).isActive = true
        view.widthAnchor.constraint(equalToConstant: TILE_WIDTH).isActive = true
        view.layer.cornerRadius = 15
        
        if number == 1 {
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 3
            view.backgroundColor = UIColor.gray
        } else {
            view.layer.borderColor = UIColor.clear.cgColor
            view.backgroundColor = UIColor.clear
        }
        
        return view
    }
    
}
