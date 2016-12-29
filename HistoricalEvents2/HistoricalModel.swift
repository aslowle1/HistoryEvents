//
//  HistoricalModel.swift
//  HistoricalEvents2
//
//  Created by Andros Slowley on 12/4/16.
//  Copyright © 2016 Andros Slowley. All rights reserved.
//

import Foundation
import UIKit

//4 Buttons(Noun)
//Image for Each button(Noun)
//Label with Text
//Buttons change items in label(Verb)
//Randon
//Remove Items from dictionary

enum ErrorList: Error {
    case noPath
    case notArrayOfStrings
}

var rounds = 6

var currentRound = 0

var roundOfEvents: [[String]] = []

var score = 0

class Events {

func grabPlistItems() throws -> [[String]]{
    guard let path = Bundle.main.path(forResource: "ListOfEvents", ofType: "plist") else {
         throw ErrorList.noPath
    }
    guard var listOfEvents = NSArray.init(contentsOfFile: path) as? [[String]] else {
        
    throw ErrorList.notArrayOfStrings
    }
    
    for _ in 0..<rounds {
    let num = arc4random_uniform(UInt32(listOfEvents.count))
        roundOfEvents.append(listOfEvents[Int(num)])
        listOfEvents.remove(at: Int(num))
    }
    return roundOfEvents

}

}






