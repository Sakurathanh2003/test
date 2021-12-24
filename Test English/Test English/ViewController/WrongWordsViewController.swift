//
//  WrongWordsViewController.swift
//  Test English
//
//  Created by Vu Thanh on 18/12/2021.
//

import UIKit
import CoreData
import AVFoundation


class WrongWordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    // MARK: Variables
    
    var listWrongWord: [NSManagedObject] = []
    let cellSpacingHeight: CGFloat = 5
    
    @IBOutlet weak var tableView: UITableView!
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          
          //1
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "WrongWord")
          
          //3
          do {
            listWrongWord = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
        tableView.reloadData()
    }
    
    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWrongWord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myWrong") as! WrongWordTableViewCell
        let item = listWrongWord[indexPath.row]
        
        cell.With(item)
        cell.soundWord.tag = indexPath.row
        cell.soundWord.addTarget(self, action: #selector(soundOfWord), for: .touchUpInside)
        
        
        return cell
    }
    @objc func soundOfWord(_ sender: UIButton){
        let indexPath1 = IndexPath(row: sender.tag, section: 0)
        let select = listWrongWord[indexPath1.row]
        
        sound(select.value(forKey: "word") as! String)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
   
        
    }
    
   

    


