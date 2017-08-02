//
//  Board.swift
//  hseGame
//
//  Created by Семен Пьянков on 07.07.17.
//  Copyright © 2017 sepy. All rights reserved.
//

import UIKit

enum color: Int {case white = 0, yellow, red, green, blue, black}

struct elem
{
    var elemColor:color
    var owner:Int
    init()
    {
        elemColor = .white
        owner     = 0
    }
}

struct boardMap
{
    var map = [String]()
    var mapSize:Int
    init()
    {
        mapSize = 0
    }
}

class board{
    let xSize = 15
    let ySize = 18
    
    var body = Array<Array<elem>>()
    
    var map = boardMap()
    var curMap:Int = 0
    
    init()
    {
        // start of Map (MUST BE IN SEPARATE CLASS!!!
        
        map.map.removeAll()
        map.mapSize = 0
        
        var inputMap:String = ""// = String.stringWithContentsOfFile("maps.txt", encoding: NSUTF8StringEncoding, error: nil)
        
        if let filepath = Bundle.main.path(forResource: "maps", ofType: "txt") {
            do {
                inputMap = try String(contentsOfFile: filepath)
                //print(inputMap)
            } catch {
                // contents could not be loaded
            }
        } else {
            // maps.txt not found!
        }
        
        //print ("\(curMap)")
        
        let mapArr = inputMap.components(separatedBy: "\n\n")
        //let mapNum:Int = Int(arc4random_uniform(UInt32(mapArr.count)))
        let chosenMap = mapArr[curMap]
        var nextMap = curMap
        while (nextMap == curMap)
        {
            nextMap = Int(arc4random_uniform(UInt32(mapArr.count)))
        }
        curMap = nextMap
        map.map = chosenMap.components(separatedBy: "\n")
        
        //print ("\(curMap)")
        
        for i in map.map
        {
            for j in i.characters
            {
                if j == "0"
                {
                    map.mapSize += 1
                }
            }
        }
        
        /*for i in map
        {
            print (i)
        }
        
        for part in mapArr
        {
            print (part)
        }*/
        // end of Map (MUST BE IN SEPARATE CLASS!!!
        
        body.removeAll()
        
        for _ in 0..<self.xSize
        {
            var tmpArr = Array<elem>()
            for _ in 0..<self.ySize
            {
                var tmpElem:elem    = elem.init()
                let colorNumber:Int = Int(arc4random_uniform(5))
                tmpElem.elemColor   = color(rawValue: colorNumber)!
                tmpArr.append(tmpElem)
            }
            self.body.append(tmpArr)
        }
        for i in 0..<self.xSize
        {
            for j in 0..<ySize
            {
                if map.map[j][map.map[i].index(map.map[i].startIndex, offsetBy: i)] == "1"
                {
                    self.body[i][j].owner = -1
                    self.body[i][j].elemColor = .black
                }
                else if map.map[j][map.map[i].index(map.map[i].startIndex, offsetBy: i)] == "0"
                {
                    self.body[i][j].owner = 0
                }
            }
        }
        
        self.body[0][0].owner = 1
        self.body[self.xSize-1][self.ySize-1].owner = 2
        while (self.body[0][0].elemColor == self.body[self.xSize-1][self.ySize-1].elemColor)
        {
            let colorNumber:Int = Int(arc4random_uniform(5))
            self.body[0][0].elemColor = color(rawValue: colorNumber)!
        }
        
        self.markElem(i: 0, j: 1, owner: self.body[0][0].owner, ownerColor: self.body[0][0].elemColor)
        self.markElem(i: 1, j: 0, owner: self.body[0][0].owner, ownerColor: self.body[0][0].elemColor)
        self.markElem(i: self.xSize-1, j: self.ySize-2, owner: self.body[self.xSize-1][self.ySize-1].owner, ownerColor: self.body[self.xSize-1][self.ySize-1].elemColor)
        self.markElem(i: self.xSize-2, j: self.ySize-1, owner: self.body[self.xSize-1][self.ySize-1].owner, ownerColor: self.body[self.xSize-1][self.ySize-1].elemColor)
    }
    
    func makeBoard ()
    {
        map.map.removeAll()
        map.mapSize = 0
        
        var inputMap:String = ""// = String.stringWithContentsOfFile("maps.txt", encoding: NSUTF8StringEncoding, error: nil)
        
        if let filepath = Bundle.main.path(forResource: "maps", ofType: "txt") {
            do {
                inputMap = try String(contentsOfFile: filepath)
                //print(inputMap)
            } catch {
                // contents could not be loaded
            }
        } else {
            // maps.txt not found!
        }
        
        let mapArr = inputMap.components(separatedBy: "\n\n")
        //let mapNum:Int = Int(arc4random_uniform(UInt32(mapArr.count)))
        let chosenMap = mapArr[curMap]
        var nextMap = curMap
        while (nextMap == curMap)
        {
            nextMap = Int(arc4random_uniform(UInt32(mapArr.count)))
        }
        curMap = nextMap
        map.map = chosenMap.components(separatedBy: "\n")
        
        for i in map.map
        {
            for j in i.characters
            {
                if j == "0"
                {
                    map.mapSize += 1
                }
            }
        }

        
        for i in 0..<self.xSize
        {
            for j in 0..<ySize
            {
                if map.map[j][map.map[i].index(map.map[i].startIndex, offsetBy: i)] == "1"
                {
                    self.body[i][j].owner = -1
                    self.body[i][j].elemColor = .black
                }
                else if map.map[j][map.map[i].index(map.map[i].startIndex, offsetBy: i)] == "0"
                {
                    self.body[i][j].owner = 0
                }
            }
        }
        for i in 0..<self.xSize
        {
            let tmpArr = Array<elem>()
            for j in 0..<self.ySize
            {
                if self.body[i][j].owner != -1
                {
                    let colorNumber:Int = Int(arc4random_uniform(5))
                    self.body[i][j].elemColor = color(rawValue: colorNumber)!
                }
            }
            self.body.append(tmpArr)
        }
        
        self.body[0][0].owner = 1
        self.body[self.xSize-1][self.ySize-1].owner = 2
        while (self.body[0][0].elemColor == self.body[self.xSize-1][self.ySize-1].elemColor)
        {
            let colorNumber:Int = Int(arc4random_uniform(5))
            self.body[0][0].elemColor = color(rawValue: colorNumber)!
        }
        
        self.markElem(i: 0, j: 1, owner: self.body[0][0].owner, ownerColor: self.body[0][0].elemColor)
        self.markElem(i: 1, j: 0, owner: self.body[0][0].owner, ownerColor: self.body[0][0].elemColor)
        self.markElem(i: self.xSize-1, j: self.ySize-2, owner: self.body[self.xSize-1][self.ySize-1].owner, ownerColor: self.body[self.xSize-1][self.ySize-1].elemColor)
        self.markElem(i: self.xSize-2, j: self.ySize-1, owner: self.body[self.xSize-1][self.ySize-1].owner, ownerColor: self.body[self.xSize-1][self.ySize-1].elemColor)

    }

    func markElem (i:Int, j:Int, owner:Int, ownerColor:color)->Int
    {
        if (i < 0 || j < 0 || i == self.xSize || j == self.ySize)
        {
            return 0
        }
        if (self.body[i][j].owner == 0 && self.body[i][j].elemColor == ownerColor)
        {
            self.body[i][j].owner = owner
            self.markElem (i: i+1, j: j, owner: owner, ownerColor: ownerColor)
            self.markElem (i: i, j: j+1, owner: owner, ownerColor: ownerColor)
            self.markElem (i: i-1, j: j, owner: owner, ownerColor: ownerColor)
            self.markElem (i: i, j: j-1, owner: owner, ownerColor: ownerColor)
        }
        return 0
    }
    
    func printBoard()->Int
    {
        var playerNum = 0
        var compNum   = 0
        for i in 0..<self.xSize
        {
            for j in 0..<self.ySize
            {
                print("\(self.body[i][j].elemColor.rawValue)", terminator:"")
            }
            print("")
        }
        
        (playerNum, compNum) = countResults()
        
        print("Player has \(playerNum) cells \nComputer has \(compNum)\n")
        return 0
    }
    
    func countResults()->(playerResult:Int, compResult:Int)
    {
        var compNum = 0
        var playerNum = 0
        for i in 0..<self.xSize
        {
            for j in 0..<self.ySize
            {
                if (self.body[i][j].owner == 1)
                {
                    playerNum+=1
                }
                else if (self.body[i][j].owner == 2)
                {
                    compNum+=1
                }
            }
        }
        
        return (playerNum, compNum)
    }
    
    func checkResults()->Int
    {
        var playerResult = 0
        var compResult = 0
        (playerResult, compResult) = self.countResults()
        if (playerResult >= self.map.mapSize/2)
        {
            return 1
        }
        if (compResult >= self.map.mapSize/2)
        {
            return 2
        }
        
        return 0
    }
    
    func makeMove(owner:Int, ownerColor:color)->Int
    {
        for i in 0..<self.xSize
        {
            for j in 0..<self.ySize
            {
                if (self.body[i][j].owner == owner)
                {
                    self.body[i][j].elemColor = ownerColor
                    self.markElem(i: i-1, j: j, owner: owner, ownerColor: ownerColor)
                    self.markElem(i: i+1, j: j, owner: owner, ownerColor: ownerColor)
                    self.markElem(i: i, j: j-1, owner: owner, ownerColor: ownerColor)
                    self.markElem(i: i, j: j+1, owner: owner, ownerColor: ownerColor)
                    
                }
            }
        }
        
        return 0
    }
    
    func seekMove(owner:Int, ownerColor:color)->Int
    {
        var added = 0
        for i in 0..<self.xSize
        {
            for j in 0..<self.ySize
            {
                if (self.body[i][j].owner == owner)
                {
                    var tmpColor:color = self.body[i][j].elemColor
                    self.body[i][j].elemColor = ownerColor
                    var tmpAdded = 0
                    added += 1
                    tmpAdded += self.seekElem(i: i-1, j: j, owner: owner, ownerColor: ownerColor, added: added)
                    tmpAdded += self.seekElem(i: i+1, j: j, owner: owner, ownerColor: ownerColor, added: added)
                    tmpAdded += self.seekElem(i: i, j: j-1, owner: owner, ownerColor: ownerColor, added: added)
                    tmpAdded += self.seekElem(i: i, j: j+1, owner: owner, ownerColor: ownerColor, added: added)
                    added += tmpAdded
                    self.body[i][j].elemColor = tmpColor
                }
            }
        }
        
        return added
    }
    
    func seekElem (i:Int, j:Int, owner:Int, ownerColor:color, added:Int)->Int
    {
        var retAdded = 0
        if (i < 0 || j < 0 || i == self.xSize || j == self.ySize)
        {
            return retAdded
        }
        if (self.body[i][j].owner == 0 && self.body[i][j].elemColor == ownerColor)
        {
            self.body[i][j].owner = owner
            retAdded += 1
            retAdded += self.seekElem (i: i+1, j: j, owner: owner, ownerColor: ownerColor, added: added)
            retAdded += self.seekElem (i: i, j: j+1, owner: owner, ownerColor: ownerColor, added: added)
            retAdded += self.seekElem (i: i-1, j: j, owner: owner, ownerColor: ownerColor, added: added)
            retAdded += self.seekElem (i: i, j: j-1, owner: owner, ownerColor: ownerColor, added: added)
            self.body[i][j].owner = 0
        }
        return retAdded
    }
    
    func findBestColor()->color
    {
        var resultColor:color = color(rawValue: 0)!
        var maxDifference = 0
        //var playerPoints = 0, computerPoints = 0
        //(playerPoints, computerPoints) = countResults()
        for i in 0..<5
        {
            if (self.body[0][0].elemColor == color(rawValue: i)! || self.body[self.xSize-1][self.ySize-1].elemColor == color(rawValue: i)!)
            {
                continue
            }
            
            //var copyThis:board = board.init()
            //copyThis.copyBoard(origin: self)
            var tmp = seekMove (owner: 2, ownerColor: color(rawValue:i)!)
            //var tmpCompPoints = 0
            //(playerPoints, tmpCompPoints) = copyThis.countResults()
            if (maxDifference <= tmp/*(tmpCompPoints - computerPoints)*/)
            {
                maxDifference = tmp/*tmpCompPoints - computerPoints*/
                resultColor   = color(rawValue: i)!
            }
        }
        /*var tmp = arc4random_uniform(5)
        var resultColor:color = color(rawValue: Int(tmp))!*/
        return resultColor
    }
    
    func findOldColor()->color
    {
        var resultColor:color = color(rawValue: 0)!
        var maxDifference = 0
        var playerPoints = 0, computerPoints = 0
        (playerPoints, computerPoints) = countResults()
        for i in 0..<5
        {
            if (self.body[0][0].elemColor == color(rawValue: i)! || self.body[self.xSize-1][self.ySize-1].elemColor == color(rawValue: i)!)
            {
                continue
            }
            
            var copyThis:board = board.init()
            copyThis.copyBoard(origin: self)
            copyThis.makeMove (owner: 2, ownerColor: color(rawValue:i)!)
            var tmpCompPoints = 0
            (playerPoints, tmpCompPoints) = copyThis.countResults()
            if (maxDifference <= (tmpCompPoints - computerPoints))
            {
                maxDifference = tmpCompPoints - computerPoints
                resultColor   = color(rawValue: i)!
            }
        }
        /*var tmp = arc4random_uniform(5)
         var resultColor:color = color(rawValue: Int(tmp))!*/
        return resultColor
    }

    
    func copyBoard (origin:board)
    {
        //board.init()
        for i in 0..<self.xSize
        {
            for j in 0..<self.ySize
            {
                body[i][j] = origin.body[i][j]
            }
        }
    }
}
