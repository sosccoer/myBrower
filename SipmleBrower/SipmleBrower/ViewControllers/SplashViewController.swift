//
//  ViewController.swift
//  SipmleBrower
//
//  Created by lelya.rumynin@gmail.com on 16.08.23.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lottieAnimation: LottieAnimationView!
    
    var animationJSON: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentAnimation()
        
    }
    
    func presentAnimation (){
        animationJSON = .init(name: "search")
        animationJSON.contentMode = .scaleAspectFit
        animationJSON.frame = lottieAnimation.bounds
        animationJSON.animationSpeed = 2.3
        animationJSON.play()
        lottieAnimation.addSubview(animationJSON)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.lottieAnimation.pause()
            
            presentBrowerViewController()
        }
        
        func presentBrowerViewController(){
            
            let browerViewController = BrowerViewController()
            browerViewController.modalPresentationStyle = .fullScreen
            present(browerViewController, animated: true)
            
        }
        
        
        
    }
    
}
