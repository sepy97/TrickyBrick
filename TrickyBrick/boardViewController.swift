//
//  boardViewController.swift
//  hseGame
//
//  Created by Семен Пьянков on 08.07.17.
//  Copyright © 2017 sepy. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class boardViewController: UIViewController {
    
    @IBOutlet weak var greenBut: UIButton!
    @IBOutlet weak var yellowBut: UIButton!
    @IBOutlet weak var redBut: UIButton!
    @IBOutlet weak var whiteBut: UIButton!
    @IBOutlet weak var blueBut: UIButton!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var compLabel: UILabel!
    @IBOutlet weak var playerColor: UILabel!
    @IBOutlet weak var compColor: UILabel!
    @IBOutlet weak var restartBut: UIButton!
    @IBOutlet weak var compBack: UILabel!
    @IBOutlet weak var playerBack: UILabel!
    @IBOutlet weak var boardLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var resultBut: UIButton!
    @IBOutlet weak var loseText: UILabel!
    
    var boardMap = Array<Array<UILabel>>()
    var buttonColors = Array<CAGradientLayer>()
    
    var myBoard:board = board.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonColors.removeAll()
        for _ in 0..<5
        {
            let tmp:CAGradientLayer = CAGradientLayer.init()
            buttonColors.append(tmp)
        }
        
        greenBut.layer.sublayers?.removeAll()
        yellowBut.layer.sublayers?.removeAll()
        redBut.layer.sublayers?.removeAll()
        whiteBut.layer.sublayers?.removeAll()
        blueBut.layer.sublayers?.removeAll()
        //UIView.transition(with: self.view, duration: 1, options: UIViewAnimationOptions.transitionCrossDissolve , animations: {
        self.drawButtons()
        self.loadBoard()
        
        self.playerBack.layer.cornerRadius   = 5
        self.playerBack.layer.masksToBounds  = true
        self.playerBack.layer.borderWidth    = 1.5
        self.playerBack.layer.borderColor    = UIColor.darkGray.cgColor
        
        self.compBack.layer.cornerRadius     = 5
        self.compBack.layer.masksToBounds    = true
        self.compBack.layer.borderWidth      = 1.5
        self.compBack.layer.borderColor      = UIColor.darkGray.cgColor
        
        self.playerColor.layer.cornerRadius  = 5
        self.playerColor.layer.masksToBounds = true
        self.playerColor.layer.borderWidth   = 1.5
        self.playerColor.layer.borderColor   = UIColor.darkGray.cgColor
        
        self.compColor.layer.cornerRadius    = 5
        self.compColor.layer.masksToBounds   = true
        self.compColor.layer.borderWidth     = 1.5
        self.compColor.layer.borderColor     = UIColor.darkGray.cgColor
       // }, completion: nil)
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        repaint()
        
    }
    
    func loadBoard ()
    {
        let rectWidth = Int(view.frame.width/CGFloat(myBoard.xSize))
        
        boardMap.removeAll()
        
        for i in 0..<myBoard.xSize
        {
            var tmpArr = Array<UILabel>()
            for j in 0..<myBoard.ySize
            {
                let label = UILabel(frame: CGRect(x: 0.5, y: 0.5, width: CGFloat(rectWidth-1), height: CGFloat(rectWidth-1)))
                
                label.layer.masksToBounds = true
                label.layer.cornerRadius  = 5
                label.layer.borderColor   = UIColor.black.cgColor
                label.layer.borderWidth   = 0.5
                switch (myBoard.body[i][j].elemColor)
                {
                case .white:
                    label.backgroundColor = UIColor.white
                case .yellow:
                    label.backgroundColor = UIColor.yellow
                case .red:
                    label.backgroundColor = UIColor.red
                case .green:
                    label.backgroundColor = UIColor.green
                case .blue:
                    label.backgroundColor = UIColor.blue
                default: break
                }
                
                tmpArr.append(label)
            }
            boardMap.append(tmpArr)
            for j in 0..<myBoard.ySize
            {
                view.addSubview(boardMap[i][j])
            }
        }
    }
    
    func repaint()
    {
        let rectWidth = Int(view.frame.width/CGFloat(myBoard.xSize))
        let xIndent   = Int((self.view.frame.width - CGFloat(myBoard.xSize*rectWidth))/2)
        let tmpy      = Int(playerBack.frame.origin.y+playerBack.frame.height)
        let yIndent   = (Int(compBack.frame.origin.y - CGFloat(tmpy))-myBoard.ySize*rectWidth)/2 + tmpy
        
        for i in 0..<myBoard.xSize
        {
            for j in 0..<myBoard.ySize
            {
                boardMap[i][j].frame = CGRect(x: 0.5+CGFloat(xIndent + i*rectWidth), y: 0.5+CGFloat(yIndent + j*rectWidth), width: CGFloat(rectWidth-1), height: CGFloat(rectWidth-1))
                
                switch (myBoard.body[i][j].elemColor)
                {
                case .white:
                    if (boardMap[i][j].backgroundColor != UIColor.white)
                    {
                        boardMap[i][j].backgroundColor = UIColor.white//boardMap[i][j].subviews[0].backgroundColor = UIColor.white
                    }
                case .yellow:
                    if (boardMap[i][j].backgroundColor != UIColor.yellow)
                    {
                        boardMap[i][j].backgroundColor = UIColor.yellow//boardMap[i][j].subviews[0].backgroundColor = UIColor.yellow
                    }
                case .red:
                    if (boardMap[i][j].backgroundColor != UIColor.red)
                    {
                        boardMap[i][j].backgroundColor = UIColor.red//boardMap[i][j].subviews[0].backgroundColor = UIColor.red
                    }
                case .green:
                    if (boardMap[i][j].backgroundColor != UIColor.green)
                    {
                        boardMap[i][j].backgroundColor = UIColor.green//boardMap[i][j].subviews[0].backgroundColor = UIColor.green
                    }
                case .blue:
                    if (boardMap[i][j].backgroundColor != UIColor.blue)
                    {
                        boardMap[i][j].backgroundColor = UIColor.blue//boardMap[i][j].subviews[0].backgroundColor = UIColor.blue
                    }
                default: break
                }
                
                if (myBoard.body[i][j].owner == -1)
                {
                    boardMap[i][j].backgroundColor = UIColor.darkGray
                }
            }
        }
        
        var player:Int, comp:Int
        (player,comp)    = myBoard.countResults()
        playerLabel.text = "Player: \(player)"
        compLabel.text   = "Computer: \(comp)"
        
        switch (myBoard.body[0][0].elemColor)
        {
        case .white:
            playerColor.backgroundColor = UIColor.white
        case .yellow:
            playerColor.backgroundColor = UIColor.yellow
        case .red:
            playerColor.backgroundColor = UIColor.red
        case .green:
            playerColor.backgroundColor = UIColor.green
        case .blue:
            playerColor.backgroundColor = UIColor.blue
        default: break
        }
        
        switch (myBoard.body[myBoard.xSize-1][myBoard.ySize-1].elemColor)
        {
        case .white:
            compColor.backgroundColor = UIColor.white
        case .yellow:
            compColor.backgroundColor = UIColor.yellow
        case .red:
            compColor.backgroundColor = UIColor.red
        case .green:
            compColor.backgroundColor = UIColor.green
        case .blue:
            compColor.backgroundColor = UIColor.blue
        default: break
        }
        
        checkButtons()
    }
    
    func drawButtons ()
    {
        greenBut.frame.size = CGSize(width: view.frame.width/5, height: view.frame.width/5)
        makeButton(button: greenBut)
        greenBut.setBackgroundImage(#imageLiteral(resourceName: "greenOn.png"), for: .normal)
        
        yellowBut.frame.size = CGSize(width: view.frame.width/5, height: view.frame.width/5)
        makeButton(button: yellowBut)
        yellowBut.setBackgroundImage(#imageLiteral(resourceName: "yellowOn"), for: .normal)
        
        redBut.frame.size = CGSize(width: view.frame.width/5, height: view.frame.width/5)
        makeButton(button: redBut)
        redBut.setBackgroundImage(#imageLiteral(resourceName: "redOn"), for: .normal)
        
        whiteBut.frame.size = CGSize(width: view.frame.width/5, height: view.frame.width/5)
        makeButton(button: whiteBut)
        whiteBut.setBackgroundImage(#imageLiteral(resourceName: "whiteOn"), for: .normal)
        
        blueBut.frame.size = CGSize(width: view.frame.width/5, height: view.frame.width/5)
        makeButton(button: blueBut)
        blueBut.setBackgroundImage(#imageLiteral(resourceName: "blueOn"), for: .normal)
    }
    
    func makeButton (button: UIButton)
    {
        button.layer.cornerRadius = view.frame.width/10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        //button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0,height: 5);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func restartButton(_ sender: Any)
    {
        myBoard.makeBoard()
        repaint()
 
    }
    @IBAction func tapRestart(_ sender: Any)
    {
        UIView.animate(withDuration: 0.5, animations: { self.restartBut.transform = CGAffineTransform(rotationAngle: CGFloat.pi) })
        UIView.animate(withDuration: 0.5, animations: { self.restartBut.transform = CGAffineTransform(rotationAngle: 2*CGFloat.pi) })
    }
    
    func checkButtons()
    {
        greenBut.isUserInteractionEnabled  = true
        greenBut.setBackgroundImage (#imageLiteral(resourceName: "greenOn.png"), for: .normal)
        yellowBut.isUserInteractionEnabled = true
        yellowBut.setBackgroundImage(#imageLiteral(resourceName: "yellowOn"), for: .normal)
        redBut.isUserInteractionEnabled    = true
        redBut.setBackgroundImage   (#imageLiteral(resourceName: "redOn"), for: .normal)
        whiteBut.isUserInteractionEnabled  = true
        whiteBut.setBackgroundImage (#imageLiteral(resourceName: "whiteOn"), for: .normal)
        blueBut.isUserInteractionEnabled   = true
        blueBut.setBackgroundImage  (#imageLiteral(resourceName: "blueOn"), for: .normal)
        
        switch myBoard.body[0][0].elemColor
        {
        case .green:  greenBut.isUserInteractionEnabled  = false
        greenBut.setBackgroundImage (#imageLiteral(resourceName: "greenOff.png"), for: .normal)
        
        case .yellow: yellowBut.isUserInteractionEnabled = false
        yellowBut.setBackgroundImage(#imageLiteral(resourceName: "yellowOff"), for: .normal)
        
        case .red:    redBut.isUserInteractionEnabled    = false
        redBut.setBackgroundImage   (#imageLiteral(resourceName: "redOff"), for: .normal)
        
        case .white:  whiteBut.isUserInteractionEnabled  = false
        whiteBut.setBackgroundImage (#imageLiteral(resourceName: "whiteOff"), for: .normal)
        
        case .blue:   blueBut.isUserInteractionEnabled   = false
        blueBut.setBackgroundImage  (#imageLiteral(resourceName: "blueOff"), for: .normal)
        
        default: break
        }
        
        switch myBoard.body[myBoard.xSize-1][myBoard.ySize-1].elemColor
        {
        case .green:  greenBut.isUserInteractionEnabled  = false
        greenBut.setBackgroundImage (#imageLiteral(resourceName: "greenOff.png"), for: .normal)
            
        case .yellow: yellowBut.isUserInteractionEnabled = false
        yellowBut.setBackgroundImage(#imageLiteral(resourceName: "yellowOff"), for: .normal)
            
        case .red:    redBut.isUserInteractionEnabled    = false
        redBut.setBackgroundImage   (#imageLiteral(resourceName: "redOff"), for: .normal)
            
        case .white:  whiteBut.isUserInteractionEnabled  = false
        whiteBut.setBackgroundImage (#imageLiteral(resourceName: "whiteOff"), for: .normal)
            
        case .blue:   blueBut.isUserInteractionEnabled   = false
        blueBut.setBackgroundImage  (#imageLiteral(resourceName: "blueOff"), for: .normal)
            
        default: break
        }
    }
    
    func winGame ()
    {
        UIView.transition(with: self.view, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve , animations: {
            self.resultText.layer.cornerRadius  = 10
            self.resultText.layer.borderWidth   = 0.5
            self.resultText.layer.borderColor   = UIColor.black.cgColor
            self.resultText.layer.masksToBounds = true
            self.resultBut.layer.cornerRadius   = 5
            self.resultBut.layer.borderWidth    = 0.5
            self.resultBut.layer.borderColor    = UIColor.black.cgColor
            self.resultBut.layer.masksToBounds  = true
            
            self.resultLabel.isHidden           = false
            self.resultText.isHidden            = false
            self.resultBut.isHidden             = false
            self.resultLabel.layer.zPosition    += 5
            self.resultText.layer.zPosition     += 5
            self.resultBut.layer.zPosition      += 5
            self.resultText.text                = "Congratulations!\n\nYou won!"
            
            self.greenBut.isUserInteractionEnabled  = false
            self.yellowBut.isUserInteractionEnabled = false
            self.redBut.isUserInteractionEnabled    = false
            self.whiteBut.isUserInteractionEnabled  = false
            self.blueBut.isUserInteractionEnabled   = false
            self.restartBut.isEnabled               = false
        }, completion: nil)
    }
    
    func loseGame ()
    {
        UIView.transition(with: self.view, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve , animations: {
            self.resultText.layer.cornerRadius  = 10
            self.resultText.layer.borderWidth   = 0.5
            self.resultText.layer.borderColor   = UIColor.black.cgColor
            self.resultText.layer.masksToBounds = true
            self.resultBut.layer.cornerRadius   = 5
            self.resultBut.layer.borderWidth    = 0.5
            self.resultBut.layer.borderColor    = UIColor.black.cgColor
            self.resultBut.layer.masksToBounds  = true
            
            self.resultLabel.isHidden           = false
            self.resultText.isHidden            = false
            self.resultBut.isHidden             = false
            self.resultLabel.layer.zPosition    += 5
            self.resultText.layer.zPosition     += 5
            self.resultBut.layer.zPosition      += 5
            self.resultText.text                = "Heeey!\n\nYou lose!"
            
            self.greenBut.isUserInteractionEnabled  = false
            self.yellowBut.isUserInteractionEnabled = false
            self.redBut.isUserInteractionEnabled    = false
            self.whiteBut.isUserInteractionEnabled  = false
            self.blueBut.isUserInteractionEnabled   = false
            self.restartBut.isEnabled = false
        }, completion: nil)

    }
    
    @IBAction func tapResult(_ sender: Any) {
        UIView.transition(with: self.view, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve , animations: {
            self.greenBut.isUserInteractionEnabled  = true
            self.yellowBut.isUserInteractionEnabled = true
            self.redBut.isUserInteractionEnabled    = true
            self.whiteBut.isUserInteractionEnabled  = true
            self.blueBut.isUserInteractionEnabled   = true
            self.restartBut.isEnabled = true
            
            self.resultLabel.isHidden        = true
            self.resultText.isHidden         = true
            self.resultBut.isHidden          = true
            self.resultLabel.layer.zPosition -= 5
            self.resultText.layer.zPosition  -= 5
            self.resultBut.layer.zPosition   -= 5
        
            self.restartButton(self)
        }, completion: nil)
        
        /*myBoard.makeBoard()
        repaint()*/
    }
    
    @IBAction func tapGreenBut(_ sender: Any) {
        playerColor.backgroundColor = UIColor.green
        
        myBoard.makeMove(owner: 1, ownerColor: .green)
        repaint()
        var result:Int = myBoard.checkResults()
        if (result == 1)
        {
            winGame()
        }
        else if (result == 2)
        {
            loseGame()
        }
        else
        {
            let tmpColor:color = myBoard.findBestColor()
            myBoard.makeMove(owner: 2, ownerColor: tmpColor)
            repaint()
            result = myBoard.checkResults()
            if (result == 1)
            {
                winGame()
            }
            else if (result == 2)
            {
                loseGame()
            }
            
        }
    }
    @IBAction func pressGreenBut(_ sender: Any) {
        greenBut.setBackgroundImage(#imageLiteral(resourceName: "greenOff.png"), for: .normal)
    }
    @IBAction func cancelGreenBut(_ sender: Any) {
        greenBut.setBackgroundImage(#imageLiteral(resourceName: "greenOn.png"), for: .normal)
    }
    
    @IBAction func tapYellowBut(_ sender: Any) {
        playerColor.backgroundColor = UIColor.yellow

        myBoard.makeMove(owner: 1, ownerColor: .yellow)
        repaint()
        var result:Int = myBoard.checkResults()
        if (result == 1)
        {
            winGame()
        }
        else if (result == 2)
        {
            loseGame()
        }
        else
        {
            let tmpColor:color = myBoard.findBestColor()
            myBoard.makeMove(owner: 2, ownerColor: tmpColor)
            repaint()
            result = myBoard.checkResults()
            if (result == 1)
            {
                winGame()
            }
            else if (result == 2)
            {
                loseGame()
            }
            
        }

    }
    @IBAction func pressYellowBut(_ sender: Any) {
        yellowBut.setBackgroundImage(#imageLiteral(resourceName: "yellowOn"), for: .normal)
    }
    @IBAction func cancelYellowBut(_ sender: Any) {
        yellowBut.setBackgroundImage(#imageLiteral(resourceName: "yellowOff"), for: .normal)
    }
    
    @IBAction func tapRedBut(_ sender: Any) {
        playerColor.backgroundColor = UIColor.red
        
        myBoard.makeMove(owner: 1, ownerColor: .red)
        repaint()
        var result:Int = myBoard.checkResults()
        if (result == 1)
        {
            winGame()
        }
        else if (result == 2)
        {
            loseGame()
        }
        else
        {
            let tmpColor:color = myBoard.findBestColor()
            myBoard.makeMove(owner: 2, ownerColor: tmpColor)
            repaint()
            result = myBoard.checkResults()
            if (result == 1)
            {
                winGame()
            }
            else if (result == 2)
            {
                loseGame()
            }
            
        }

    }
    @IBAction func pressRedBut(_ sender: Any) {
        redBut.setBackgroundImage(#imageLiteral(resourceName: "redOn"), for: .normal)
    }
    @IBAction func cancelRedBut(_ sender: Any) {
        redBut.setBackgroundImage(#imageLiteral(resourceName: "redOff"), for: .normal)
    }
    
    @IBAction func tapWhiteBut(_ sender: Any) {
        playerColor.backgroundColor = UIColor.white
        
        myBoard.makeMove(owner: 1, ownerColor: .white)
        repaint()
        var result:Int = myBoard.checkResults()
        if (result == 1)
        {
            winGame()
        }
        else if (result == 2)
        {
            loseGame()
        }
        else
        {
            let tmpColor:color = myBoard.findBestColor()
            myBoard.makeMove(owner: 2, ownerColor: tmpColor)
            repaint()
            result = myBoard.checkResults()
            if (result == 1)
            {
                winGame()
            }
            else if (result == 2)
            {
                loseGame()
            }
        }
    }
    @IBAction func pressWhiteBut(_ sender: Any) {
        whiteBut.setBackgroundImage(#imageLiteral(resourceName: "whiteOn"), for: .normal)
    }
    @IBAction func cancelWhiteBut(_ sender: Any) {
        whiteBut.setBackgroundImage(#imageLiteral(resourceName: "whiteOff"), for: .normal)
    }
    
    @IBAction func tapBlueBut(_ sender: Any) {
        playerColor.backgroundColor = UIColor.blue
        
        myBoard.makeMove(owner: 1, ownerColor: .blue)
        repaint()
        var result:Int = myBoard.checkResults()
        if (result == 1)
        {
            winGame()
        }
        else if (result == 2)
        {
            loseGame()
        }
        else
        {
            let tmpColor:color = myBoard.findBestColor()
            myBoard.makeMove(owner: 2, ownerColor: tmpColor)
            repaint()
            result = myBoard.checkResults()
            if (result == 1)
            {
                winGame()
            }
            else if (result == 2)
            {
                loseGame()
            }
        }
    }
    @IBAction func pressBlueBut(_ sender: Any) {
        blueBut.setBackgroundImage(#imageLiteral(resourceName: "blueOn"), for: .normal)
    }
    @IBAction func cancelBlueBut(_ sender: Any) {
        blueBut.setBackgroundImage(#imageLiteral(resourceName: "blueOff"), for: .normal)
    }
}
