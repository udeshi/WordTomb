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
    var sugesstions=[Question]()
    var uniqueLetters = Set<Character>()
    var randomIndexes=[[String:Any]]()
    let TILE_WIDTH : CGFloat = 70
    let TILE_HEIGHT : CGFloat = 70
    let MAX_GRID_TILES = 10
    var gridMap = [[Int]]()
    var viewArray : [[UIView]] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initiliaze()
        if (sugesstions.count > 0){
            creatGridArray()
            createViewArray()
            loadTilesToGrid()
        }
    }
    
    func initiliaze(){
        let categoryType = UserDefaultsHandler().getData(key: "selectedCategoryId")
           let selectedLevel = UserDefaultsHandler().getData(key: "selectedLevel")
        sugesstions = CoreDataHandler.fetchQuestions(level: Int(selectedLevel)!, type: Int(categoryType)!)
        if(sugesstions.count > 0){
            let randomIndex = Common().getRandomNumber(arrayCount: sugesstions.count)
            let question = sugesstions[randomIndex]
             //print(question.answer)
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
        //var previousIndex =  randomIndexes.last
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
            //print(question.answer)
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
                    //print("even",gameQuestions[questionIndex].answer)
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
