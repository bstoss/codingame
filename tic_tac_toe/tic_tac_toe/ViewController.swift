//
//  ViewController.swift
//  tic_tac_toe
//
//  Created by Björn Roßborsky-Stoß on 14.01.22.
//

import UIKit

class ViewController: UIViewController {

    var gameController: GameViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.

        let gameController = GameViewController()
        self.gameController = gameController
    
//        controller.view.frame = ...  // or, better, turn off `translatesAutoresizingMaskIntoConstraints` and then define constraints for this subview
        view.addSubview(gameController.view)
        gameController.didMove(toParent: self)
    }


}

