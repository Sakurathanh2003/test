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
    
// Delete + Update a cell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let sectionW = wordSection[indexPath.section]
        let word = sectionW.words[indexPath.row]
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // Call update action
            self.updateWord(word, indexPath: indexPath)
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            // Call delete action
            self.deleteWord(word, indexPath: indexPath)
        }
        editAction.backgroundColor = .blue
        deleteAction.backgroundColor = .red
        return [editAction, deleteAction]
    }
    
// MARK: Function
    private func deleteWord(_ word: Word, indexPath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Are you sure", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ (action) in
            self.wordSection[indexPath.section].words.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func updateWord(_ word: Word, indexPath: IndexPath){
        let alert = UIAlertController(title: "Edit Word", message: "Update a Word", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // word
        alert.addTextField { field in
            field.placeholder = "word"
            field.text = word.word
            field.returnKeyType = .next
        }
        
        // mean
        alert.addTextField { field in
            field.placeholder = "mean"
            field.text = word.mean
            field.returnKeyType = .next
        }
        
        // pronunciation
        alert.addTextField { field in
            field.placeholder = "pronunciation"
            field.text = word.pronunciation
            field.returnKeyType = .next
        }
        
        // category
        alert.addTextField { field in
            field.placeholder = "category"
            field.text = word.category
            field.returnKeyType = .next
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {  _ in
            guard let fields = alert.textFields, fields.count == 4 else {return}
            let wordPlace = fields[0]
            let meanPlace = fields[1]
            let proPlace = fields[2]
            let catePlace = fields[3]
            
            self.wordSection[indexPath.section].words[indexPath.row].word = wordPlace.text!
            self.wordSection[indexPath.section].words[indexPath.row].mean = meanPlace.text!
            self.wordSection[indexPath.section].words[indexPath.row].category = catePlace.text!
            self.wordSection[indexPath.section].words[indexPath.row].pronunciation = proPlace.text!
            
            
            self.tableView.reloadData()
        }
        
        
        
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
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


