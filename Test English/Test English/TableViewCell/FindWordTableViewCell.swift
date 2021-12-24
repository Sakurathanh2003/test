//
//  FindWordTableViewCell.swift
//  Test English
//
//  Created by Vu Thanh on 24/12/2021.
//

import UIKit

class FindWordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        wordLabel.textColor = .systemPink
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(_ with: Word){
        wordLabel.text = with.word
        meanLabel.text = with.mean
    }
    
}
