//
//  ViewController.swift
//  HistoricalEvents2
//
//  Created by Andros Slowley on 12/4/16.
//  Copyright © 2016 Andros Slowley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var segue: UIStoryboardSegue! {didSet {print(segue.identifier)}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEvents()
        countDown()
        let image = UIImage.init(named: "splash_screen")
        
        view.backgroundColor = UIColor.init(patternImage: image!)
        
        buttonTag()
       info.isHidden = true
        currentRound = 0
        score = 0
        
        
    }
    
    
    
    
    @IBAction func upperMostButtonPress() {
    let uppertext = upperMost.text
        upperMost.text = midUpper.text
        midUpper.text = uppertext
    }
    
    @IBAction func midUpperLowerButtonPress() {
        let uppertext = midUpper.text
        midUpper.text = midLower.text
        midLower.text = uppertext
    }
    
    @IBAction func lowerMostButtonPress() {
        let uppertext = midLower.text
        midLower.text = lowerMost.text
        lowerMost.text = uppertext
        
    }
    
    
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var upperMost: UILabel!

    @IBOutlet weak var midUpper: UILabel!

    @IBOutlet weak var midLower: UILabel!

    @IBOutlet weak var lowerMost: UILabel!
    
    @IBOutlet weak var nextQuestion: UIButton!
    
    @IBOutlet weak var info: UILabel!

    @IBAction func onToTheNextQuestion(_ sender: UIButton) {
        counter = 60
        self.timer.isHidden = false
        getEvents()
    }
    
    
    
    
    func buttonTag() {
        var buttonHighlights: [Int: String] = [0: "down_full_selected", 1: "up_half_selected", 2: "down_half_selected", 3: "up_full_selected" ]
        for index in view.subviews {
            if index is UIButton {
                let index2 = index as! UIButton
                if index2.currentTitle != "nextQuestion" && buttonHighlights[index2.tag] != nil {
                    index2.setImage(UIImage.init(named: buttonHighlights[index2.tag]!), for: .highlighted)
                }
                }
        }
        }
    

    func perform() {
        segue = UIStoryboardSegue.init(identifier: "next", source: self, destination: NewGameViewController(), performHandler: { () in return self.present(NewGameViewController(), animated: true, completion: nil)  })
        segue.perform()
        
    }
    
    func getEvents() {
        info.isHidden = true
        counter = 60
        if counter > 0 {
            nextQuestion.isHidden = true
        }
        let labels = [upperMost, midUpper, midLower, lowerMost]
        var first = try! Events().grabPlistItems()[currentRound]
        var num = 4
        for index in labels {
            let tempNum = Int(arc4random_uniform(UInt32(num)))
            index?.text = first[tempNum]
            first.remove(at: tempNum)
            num -= 1
        }
              print(roundOfEvents[currentRound])
        
    
}
    
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if [upperMost!.text!, midUpper!.text!, midLower!.text!, lowerMost!.text!] == roundOfEvents[currentRound] && event?.subtype == motion && counter > 0
        {
            if currentRound <= 4 {
                self.timer.isHidden = true
                counter = -1
                print("completed round \(currentRound)")
            currentRound += 1
                nextQuestion.isHidden = false
                nextQuestion.setImage(UIImage.init(named: "next_round_success"), for: UIControlState())
                score += 1
            
                print(score)
            } else if currentRound == 5{
            print(score)
            score += 1
                counter = -3
                self.perform()}}
    }
    
    
    var counter = 60
    
    func countDown() {
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    func update() {
        
        if(counter > -1){
            let minutes = String(counter / 60)
            let seconds = String(counter % 60)
            if counter % 60 == 0 {timer.text = minutes + ":" + seconds + "0"} else {timer.text = minutes + ":" + seconds }
            counter -= 1
            if counter == 0 && currentRound < 5 { present(displayCorrectAnswers(), animated: true, completion: nil
                )}
            else if counter == 0 && currentRound == 5 { counter = -2
                present(displayCorrectAnswers(), animated: true, completion: nil)
                
                }
            
        }
        
        }
    
    func timeDelay() {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
        self.perform();
        self.nextQuestion.isHidden = false
        self.info.isHidden = false
    })
    }
    
    func displayCorrectAnswers() -> UIViewController {
        let alert = UIAlertController.init(title: "Time-Up", message: "The correct answer is \(roundOfEvents[currentRound])", preferredStyle: .actionSheet)
       
        let options = UIAlertAction.init(title: "Okay", style: .default, handler: {(action: UIAlertAction) in if currentRound == 5 { self.nextQuestion.isHidden = true; self.counter = -2; self.timeDelay()} else if currentRound < 5 {  }}  )
        alert.addAction(options)
        nextQuestion.isHidden = false
        timer.isHidden = true
        nextQuestion.setImage(UIImage.init(named: "next_round_fail"), for: UIControlState())
        currentRound += 1
        return alert
        
    }
    
    
    
    
}
