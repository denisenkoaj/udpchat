//
//  UIChatTableViewCell.swift
//  udpchat
//
//  Created by Aleksandr Denisenko on 6/15/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import UIKit

class UIChatTableViewIncomingCell: UITableViewCell {

    // MARK: - Outlets 
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    // MARK: - Configure cell
    
    
    func configure(withMessage message: ChatMessage) {
        
        // Setup cell data
        self.messageTextView.text = message.message
        self.timeLabel.text = message.time
        
        // Setup dynamic height for textView
        let sizeThatFitsTextView: CGSize =  messageTextView.sizeThatFits(CGSize(width: messageTextView.frame.size.width, height: CGFloat(MAXFLOAT)))
        textViewHeightConstraint.constant = sizeThatFitsTextView.height
        
        backView.layer.cornerRadius = 10
    
    }
    
    
   
}
