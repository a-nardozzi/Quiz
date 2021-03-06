//
//  ViewController.swift
//  Quiz
//
//  Created by Alexander Nardozzi on 1/18/17.
//  Copyright © 2017 Alex Nardozzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = [
      "What is 7+7?",
      "What is the capital of Vermont?",
      "What is Cognac made from?"
    ]
    
    let answers: [String] = [
      "14",
      "Montpelier",
      "Grapes"
    ]
    var currentQuestionIndex: Int = 0
    
    
    
    
    @IBAction func showNextQuestion(_ sender: UIButton){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count * 2 {
          currentQuestionIndex = 0
        }
        if currentQuestionIndex % 2 == 0 {
            let question: String = questions[currentQuestionIndex / 2]
            nextQuestionLabel.text = question
            answerLabel.text = "???"
        } else {
            nextQuestionLabel.text = ""
            answerLabel.text = "???"
        }
        
        animateLabelTransitions()
    }
    
    
    
    
    @IBAction func showAnswer(_ sender: UIButton){
        if currentQuestionIndex % 2 == 0 {
            let answer: String = answers[currentQuestionIndex / 2]
            answerLabel.text = answer
        }
    }
    
    
    
    
    override func viewDidLoad(){
      super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        updateOffScreenLabel()
    }
    
    
    

    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    
    
    
    func animateLabelTransitions() {
        // Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        
        //Animate the alpha
        //and the Center X Constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.2,
            options: [.curveLinear],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                
                self.updateOffScreenLabel()
        })
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
        
    }
}

