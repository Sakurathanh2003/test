//
//  TestViewController.swift
//  Test English
//
//  Created by Vu Thanh on 20/12/2021.
//

import UIKit
import CoreData
import AVFoundation

class TestViewController: UIViewController {
    
    let data = DataLoader().wordData
    var a: Word!
    var b: Word!
    var c: Word!
    var d: Word!
    var dapan: Word!
    var corrected: Int = 0
    let talk = AVSpeechSynthesizer()
    
// MARK: Outlet
    @IBOutlet weak var meanText: UILabel!
    @IBOutlet weak var aText: UILabel!
    @IBOutlet weak var bText: UILabel!
    @IBOutlet weak var cText: UILabel!
    @IBOutlet weak var dText: UILabel!
    @IBOutlet weak var trueNumberAns: UILabel!
    @IBOutlet weak var inputTextToSpeak: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tat ban phim 
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
        randomCheck()
        aText.text = a.word + " " + "(\(a.category))"
        bText.text = b.word + " " + "(\(b.category))"
        cText.text = c.word + " " + "(\(c.category))"
        dText.text = d.word + " " + "(\(d.category))"
        meanText.text = dapan.mean
        trueNumberAns.text = "You're choose corrected \(corrected) / 3365"
    }
    
    
   
   
// MARK: Notifications
    func trueAnswer(){
        let alert = UIAlertController(title: "Exactly", message: "Correct", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.corrected += 1
            self.randomCheck()
            self.viewDidLoad()
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func wrongAnswer(){
        let alert = UIAlertController(title: "Wrong", message: "You're choose wrong", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.addWordWrong(word: self.dapan)
            self.viewDidLoad()
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
// MARK: Function
    func randomCheck(){
        self.a = data.randomElement()!
        self.b = data.randomElement()!
        self.c = data.randomElement()!
        self.d = data.randomElement()!
        
        let hop = [a, b, c, d]
        self.dapan = hop.randomElement()!
    }
    
    func addWordWrong(word: Word){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
        // 1
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
        // 2
        let entity =
        NSEntityDescription.entity(forEntityName: "WrongWord",
                                       in: managedContext)!
          
        let word = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
          
        // 3
        word.setValue(dapan.word, forKey: "word")
        word.setValue(dapan.pronunciation, forKey: "pronunciation")
        word.setValue(dapan.category, forKey: "category")
        word.setValue(dapan.mean, forKey: "mean")
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
        
    }
    
// MARK: Action
    @IBAction func a_click(_ sender: Any){
        if a.word == dapan.word {
            trueAnswer()
        } else {
            wrongAnswer()
        }
    }
    @IBAction func b_click(_ sender: Any) {
        if b.word == dapan.word {
            trueAnswer()
        } else {
            wrongAnswer()
        }
    }
    
    @IBAction func c_click(_ sender: Any) {
        if c.word == dapan.word {
            trueAnswer()
        } else {
            wrongAnswer()
        }
    }
    @IBAction func d_click(_ sender: Any) {
        if d.word == dapan.word {
            trueAnswer()
        } else {
            wrongAnswer()
        }
    }
    
    @IBAction func a_read(_ sender: Any) {
        sound(a.word)
    }
    
    @IBAction func b_read(_ sender: Any) {
        sound(b.word)
    }
    
    @IBAction func c_read(_ sender: Any) {
        sound(c.word)
    }
    
    @IBAction func d_read(_ sender: Any) {
        sound(d.word)
    }
    
    @IBAction func speakInputText(_ sender: Any) {
        if inputTextToSpeak.text != "" {
            sound(inputTextToSpeak.text ?? "")
        }
    }
    
}


