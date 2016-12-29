//
//  NaviViewController.swift
//  HistoricalEvents2
//
//  Created by Andros Slowley on 12/10/16.
//  Copyright © 2016 Andros Slowley. All rights reserved.
//

import UIKit

class NaviViewController: UINavigationController {

    var segue: UIStoryboardSegue! {didSet {print(segue.identifier)}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEvents()
        countDown()
        let image = UIImage.init(named: "splash_screen")
        
        view.backgroundColor = UIColor.init(patternImage: image!)
        
        buttonTag()
        info.hidden = true
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
    
    @IBAction func onToTheNextQuestion(sender: UIButton) {
        counter = 60
        self.timer.hidden = false
        getEvents()
    }
    
    
    
    
    func buttonTag() {
        var buttonHighlights: [Int: String] = [0: "down_full_selected", 1: "up_half_selected", 2: "down_half_selected", 3: "up_full_selected" ]
        for index in view.subviews {
            if index is UIButton {
                let index2 = index as! UIButton
                if index2.currentTitle != "nextQuestion" && buttonHighlights[index2.tag] != nil {
                    index2.setImage(UIImage.init(named: buttonHighlights[index2.tag]!), forState: .Highlighted)
                }
            }
        }
    }
    
    
    func perform() {
        segue = UIStoryboardSegue.init(identifier: "next", source: self, destination: NewGameViewController(), performHandler: { () in return self.presentViewController(NewGameViewController(), animated: true, completion: nil)  })
        segue.perform()
        
    }
    
    func getEvents() {
        info.hidden = true
        counter = 60
        if counter > 0 {
            nextQuestion.hidden = true
        }
        let labels = [upperMost, midUpper, midLower, lowerMost]
        var first = try! Events().grabPlistItems()[currentRound]
        var num = 4
        for index in labels {
            let tempNum = Int(arc4random_uniform(UInt32(num)))
            index.text = first[tempNum]
            first.removeAtIndex(tempNum)
            num -= 1
        }
        print(roundOfEvents[currentRound])
        
        
    }
    
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if [upperMost!.text!, midUpper!.text!, midLower!.text!, lowerMost!.text!] == roundOfEvents[currentRound] && event?.subtype == motion && counter > 0
        {
            if currentRound <= 4 {
                self.timer.hidden = true
                counter = -1
                print("completed round \(currentRound)")
                currentRound += 1
                nextQuestion.hidden = false
                nextQuestion.setImage(UIImage.init(named: "next_round_success"), forState: .Normal)
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
        _ = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    func update() {
        
        if(counter > -1){
            let minutes = String(counter / 60)
            let seconds = String(counter % 60)
            if counter % 60 == 0 {timer.text = minutes + ":" + seconds + "0"} else {timer.text = minutes + ":" + seconds }
            counter -= 1
            if counter == 0 && currentRound < 5 { presentViewController(displayCorrectAnswers(), animated: true, completion: nil
                )}
            else if counter == 0 && currentRound == 5 { counter = -2
                presentViewController(displayCorrectAnswers(), animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    func timeDelay() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.perform();
            self.nextQuestion.hidden = false
            self.info.hidden = false
        })
    }
    
    func displayCorrectAnswers() -> UIViewController {
        let alert = UIAlertController.init(title: "Time-Up", message: "The correct answer is \(roundOfEvents[currentRound])", preferredStyle: .ActionSheet)
        
        let options = UIAlertAction.init(title: "Okay", style: .Default, handler: {(action: UIAlertAction) in if currentRound == 5 { self.nextQuestion.hidden = true; self.counter = -2; self.timeDelay()} else if currentRound < 5 {  }}  )
        alert.addAction(options)
        nextQuestion.hidden = false
        timer.hidden = true
        nextQuestion.setImage(UIImage.init(named: "next_round_fail"), forState: .Normal)
        currentRound += 1
        return alert
        
    }
    
    
    
    
}
