//
//  NewGameViewController.swift
//  HistoricalEvents2
//
//  Created by Andros Slowley on 12/5/16.
//  Copyright © 2016 Andros Slowley. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    var playAgainButton = UIButton()
    
    var scoreDisplay = UILabel()
    
    func buttonSetup() {
       
        scoreDisplay.bounds = CGRect.init(x: 0, y: 0, width: 600, height: 400)
        scoreDisplay.text = "Final Score: \n\(score)/6"
        scoreDisplay.textColor = UIColor.white
        scoreDisplay.numberOfLines = 0
        scoreDisplay.font.withSize(60.0)
        scoreDisplay.textAlignment = .center
    
        playAgainButton.setImage(UIImage.init(named: "play_again"), for: UIControlState())
        
        playAgainButton.addTarget(self, action: #selector(self.getRidOf), for: .touchUpInside)
    }
    
    func getRidOf() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetup()
        view.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "splash_screen")!)
    }

    override func viewWillLayoutSubviews() {
    view.addSubview(playAgainButton)
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),playAgainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor), playAgainButton.widthAnchor.constraint(equalToConstant: 150), playAgainButton.heightAnchor.constraint(equalToConstant: 50.0)])
        
        
        view.addSubview(scoreDisplay)
        scoreDisplay.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([scoreDisplay.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0),
        scoreDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        
    }

   
}


