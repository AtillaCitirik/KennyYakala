//
//  ViewController.swift
//  KennyYakalaApp
//
//  Created by Atilla Çıtırık on 1.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblHighScore: UILabel!
    @IBOutlet weak var imgKenny1: UIImageView!
    @IBOutlet weak var imgKenny2: UIImageView!
    @IBOutlet weak var imgKenny3: UIImageView!
    @IBOutlet weak var imgKenny4: UIImageView!
    @IBOutlet weak var imgKenny5: UIImageView!
    @IBOutlet weak var imgKenny6: UIImageView!
    @IBOutlet weak var imgKenny7: UIImageView!
    @IBOutlet weak var imgKenny8: UIImageView!
    @IBOutlet weak var imgKenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        lblScore.text = "Score \(score)"
        
        //highScore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            lblHighScore.text = "HighScore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            lblHighScore.text = "HighScore \(highScore)"
        }
        
        imgKenny1.isUserInteractionEnabled = true
        imgKenny2.isUserInteractionEnabled = true
        imgKenny3.isUserInteractionEnabled = true
        imgKenny4.isUserInteractionEnabled = true
        imgKenny5.isUserInteractionEnabled = true
        imgKenny6.isUserInteractionEnabled = true
        imgKenny7.isUserInteractionEnabled = true
        imgKenny8.isUserInteractionEnabled = true
        imgKenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        imgKenny1.addGestureRecognizer(recognizer1)
        imgKenny2.addGestureRecognizer(recognizer2)
        imgKenny3.addGestureRecognizer(recognizer3)
        imgKenny4.addGestureRecognizer(recognizer4)
        imgKenny5.addGestureRecognizer(recognizer5)
        imgKenny6.addGestureRecognizer(recognizer6)
        imgKenny7.addGestureRecognizer(recognizer7)
        imgKenny8.addGestureRecognizer(recognizer8)
        imgKenny9.addGestureRecognizer(recognizer9)
        
        
        kennyArray = [imgKenny1,imgKenny2,imgKenny3,imgKenny4,imgKenny5,imgKenny6,imgKenny7,imgKenny8,imgKenny9]
        
        
        //Timer
        counter = 10
        lblTimer.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
    }
    
    
    
    @objc func hideKenny(){
        
        for kenyy in kennyArray{
            kenyy.isHidden = true;
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden = false;
        
    }
    
    
    @objc func increaseScore(){
        score += 1
        lblScore.text = "Score: \(score)"
    }
    
    @objc func CountDown(){
        counter -= 1
        lblTimer.text = "\(counter)"
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            if self.score > self.highScore{
                self.highScore = self.score
                lblHighScore.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            
            let okbutton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "REPLAY", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.lblScore.text = "Score: \(self.score)"
                self.counter = 10
                self.lblTimer.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.CountDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okbutton)
            alert.addAction(replayButton)
            self.present(alert, animated: true,completion: nil)
            
            
        }
    }


}

