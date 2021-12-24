//
//  WrongWordTableViewCell.swift
//  Test English
//
//  Created by Vu Thanh on 19/12/2021.
//

import UIKit
import AVFoundation
import CoreData

class WrongWordTableViewCell: UITableViewCell {
    
    
    // MARK: IBOutlet
    @IBOutlet weak var wordText: UILabel!
    @IBOutlet weak var meanText: UILabel!
    @IBOutlet weak var soundWord: UIButton!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        wordText.textColor = .red
        
        meanText.textColor = .purple
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 1 // do day duong vien
         
        // self.layer.cornerRadius = 20 // bo vien
        self.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func With(_ with: NSManagedObject){
        
        let pronunciation  = with.value(forKey: "pronunciation") as! String

        wordText.text = with.value(forKey: "word") as! String  + " /\(pronunciation)/" 
        meanText.text = with.value(forKey: "mean") as? String
        
    }

}
