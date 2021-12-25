//
//  FindWordViewController.swift
//  Test English
//
//  Created by Vu Thanh on 23/12/2021.
//

import UIKit
import CoreAudio

struct CharacterSection {
    var char: String
    var words: [Word]
}

class FindWordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
    var data = DataLoader().wordData
    var dataWord = DataLoader().wordData
    var wordSection = [CharacterSection]()
    var nameSection = [String]()
     
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchWord: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let dic = Dictionary(grouping: self.dataWord) { (word) in
            return String(word.word.first!)
        }
        
        self.wordSection = dic.map { (key, value) in
            return CharacterSection(char: key, words: value)
        }
        
        self.wordSection = wordSection.sorted {
            return $0.char < $1.char
        }
        
        self.nameSection = dic.map { (key) in
            return key.key.uppercased()
        }
        
        self.nameSection = nameSection.sorted {
            return $0 < $1
        }
        
        
        
    }
    
    
// MARK: Table View Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wordSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = wordSection[section]
        let number = section.words.count
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myWord") as! FindWordTableViewCell
        
        let section = wordSection[indexPath.section]
        let item = section.words[indexPath.row]
        
        
        cell.fillCell(item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = wordSection[section]
        let name = section.char.uppercased()
        return name
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nameSection
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let addTableViewController = segue.destination as! AddTableViewController
            addTableViewController.delegate = self
        }
    }
    
    
// MARK: SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchWord.text?.lowercased()
        if text == "" {
            dataWord = data
            
        } else {
            dataWord = []
            for word in data {
                let textEnglish = word.word
                if (textEnglish.contains(text ?? "")){
                    dataWord.append(word)
                }
            }
        }
        viewDidLoad()
        tableView.reloadData()
    }
// MARK: Action
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: nil)
    }
    
}

extension FindWordViewController: AddTableViewDelegate {
    func addNew(with: Word) {
        self.data.append(with)
        tableView.reloadData()
    }
}


