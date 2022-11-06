//
//  TutorialView.swift
//  TutorialView
//
//  Created by Олег Федоров on 11.09.2022.
//

import UIKit

enum TutorialStep {
    case first
    case second
}

protocol TutorialViewDelegate: AnyObject {
    func tutorialViewFirstStepAction(_ view: TutorialView)
    func tutorialViewSecondStepAction(_ view: TutorialView)
}

class TutorialView: UIView {
    
    weak var delegate: TutorialViewDelegate?
    
    private var backLayerWithHole: CAShapeLayer?
    private var closeTutorialButton: UIButton?
    
    private let position: CGPoint
    private let anchorPoint: CGPoint
    private let step: TutorialStep
    
    init(frame: CGRect,
         position: CGPoint,
         anchorPoint: CGPoint,
         step: TutorialStep) {
        self.position = position
        self.anchorPoint = anchorPoint
        self.step = step
        
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        let button = UIButton()
        button.addTarget(self, action: #selector(showNext), for: .touchUpInside)
        closeTutorialButton = button
        addSubview(button)
        
        let clearRect = CGRect(origin: position,
                               size: CGSize(width: 100,
                                            height: 100))
        
        backLayerWithHole = makeClearHole(rect: clearRect,
                                          anchorPoint: anchorPoint)
        guard let backLayerWithHole = backLayerWithHole else { return }
        layer.addSublayer(backLayerWithHole)
        
        closeTutorialButton?.frame = clearRect
    }
    
    @objc
    private func showNext() {
        switch step {
        case .first:
            delegate?.tutorialViewFirstStepAction(self)
        case .second:
            delegate?.tutorialViewSecondStepAction(self)
        }
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
}

