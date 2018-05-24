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
    var randomIndexes=[Int]()
    let TILE_WIDTH : CGFloat = 100
    let TILE_HEIGHT : CGFloat = 100
    
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
     
        gameQuestions.append(questions[randomIndex])
        questions.remove(at: Int(randomIndex))
        getOtherQuestions(questions: questions, comparedWith: 0)
    }
    
    private func getOtherQuestions(questions: [Question], comparedWith: Int){
        var questionCopy = questions
        let letters = Array((gameQuestions[comparedWith]).answer!)
        var randomIndex = Common().getRandomNumber(arrayCount: (letters.count))
        let compatibleQuestions = questions.filter{
            ($0.answer?.contains(where: {$0==letters[randomIndex]}))!
        }
        if(compatibleQuestions.count>0){
            randomIndexes.append(randomIndex)
            randomIndex = Common().getRandomNumber(arrayCount: compatibleQuestions.count)
            gameQuestions.append(compatibleQuestions[randomIndex])
            questionCopy.remove(at: randomIndex)
            print(gameQuestions)
        }
        if(questionCopy.count>0){
            getOtherQuestions(questions: questionCopy, comparedWith: gameQuestions.count - 1)
        }
    }
    
    fileprivate func creatGridArray(){
        let maxGridLength = gameQuestions.max { ($0.answer!.count < $1.answer!.count)}
        print(maxGridLength!)
        
//        for(var i=0; i<maxGridLength;i++){
//
//        }
        
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
        for r in tempDataAray {
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
