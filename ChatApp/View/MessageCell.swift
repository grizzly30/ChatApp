//
//  MessageCell.swift
//  ChatApp
//
//  Created by Mihailo Jovanovic on 18.10.21..
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var leftImageCell: UIImageView!
    @IBOutlet weak var leftLabelCell: UILabel!
    @IBOutlet weak var rightLabelCell: UILabel!
    @IBOutlet weak var rightImageCell: UIImageView!
    @IBOutlet weak var bodyLabelCell: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.messageBubble.layer.cornerRadius = 5;
        self.messageBubble.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
