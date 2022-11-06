//
//  ViewController.swift
//  TutorialView
//
//  Created by Олег Федоров on 11.09.2022.
//

import UIKit

class ViewController: UIViewController {

    private var tutorialView: TutorialView?
    
    @IBOutlet private weak var showTutorialButton: UIButton!
    @IBOutlet private weak var firstStepButton: UIButton!
    @IBOutlet private weak var secondStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        showTutorialButton.isHidden = true
        setupTutorialViewWithPosition(
            CGPoint(x: firstStepButton.frame.midX - 50,
                    y: firstStepButton.frame.minY - firstStepButton.frame.height / 2),
            anchorPoint: CGPoint(x: firstStepButton.frame.midX / view.frame.width,
                                 y: firstStepButton.frame.midY / view.frame.height),
            tutorialStep: .first
        )
    }

    @IBAction func showTutorial(_ sender: UIButton) {
        sender.isHidden = true
        setupTutorialViewWithPosition(
            CGPoint(x: firstStepButton.frame.midX - 50,
                    y: firstStepButton.frame.minY - firstStepButton.frame.height / 2),
            anchorPoint: CGPoint(x: firstStepButton.frame.midX / view.frame.width,
                                 y: firstStepButton.frame.midY / view.frame.height),
            tutorialStep: .first
        )
    }
    
    @IBAction func firstStepAction(_ sender: UIButton) {
        showAlertForStepActionWithTitle("STEP 1",
                                        message: "make something")
    }
    
    @IBAction func secondStepAction(_ sender: UIButton) {
        showAlertForStepActionWithTitle("STEP 2",
                                        message: "make something")
    }
    
    private func setupTutorialViewWithPosition(_ position: CGPoint,
                                               anchorPoint: CGPoint,
                                               tutorialStep: TutorialStep) {
        tutorialView = TutorialView(frame: view.bounds,
                                    position: position,
                                    anchorPoint: anchorPoint,
                                    step: tutorialStep)
        guard let tutorialView = tutorialView else { return }
        tutorialView.delegate = self
        view.addSubview(tutorialView)
    }
    
    private func showAlertForStepActionWithTitle(_ title: String,
                                                 message: String,
                                                 actionBlock: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            actionBlock?()
        }
        
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension ViewController:TutorialViewDelegate {
    func tutorialViewFirstStepAction(_ view: TutorialView) {
        showAlertForStepActionWithTitle("STEP 1",
                                        message: "make something") {
            self.setupTutorialViewWithPosition(
                CGPoint(
                    x: self.secondStepButton.frame.midX - 50,
                    y: self.secondStepButton.frame.minY - self.secondStepButton.frame.height / 2
                ),
                anchorPoint: CGPoint(
                    x: self.secondStepButton.frame.midX / self.view.frame.width,
                    y: self.secondStepButton.frame.midY / self.view.frame.height
                ),
                tutorialStep: .second
            )
        }
    }
    
    func tutorialViewSecondStepAction(_ view: TutorialView) {
        showAlertForStepActionWithTitle("STEP 2",
                                        message: "make something") {
            DispatchQueue.main.async {
                self.showTutorialButton.isHidden = false
            }
        }
    }
}
