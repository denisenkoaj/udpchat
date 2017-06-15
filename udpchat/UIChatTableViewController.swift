//
//  UIChatTableViewController.swift
//  udpchat
//
//  Created by Aleksandr Denisenko on 6/15/17.
//  Copyright © 2017 Aleksandr Denisenko. All rights reserved.
//

import UIKit

class UIChatTableViewController: UITableViewController {
    
    var isPrintingNow: Bool = false
    var udpManager: UDPManager?
    // MARK: - Variables
    
    var messages: [ChatMessage] = [] {
        didSet {
            updateData()
        }
    }
    
    // MARK: - Life cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.udpManager = UDPManager()
        self.udpManager?.delegate = self
    }
    
    // MARK: - Methods
    
    func setupView() {
        
        // Setup table view
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        //tableView.frame.size.height = -30 // 30 it's height for textfield in bottom of screen
        
        
        // Register cell
        let outcomingNibName = UINib(nibName: "UIChatTableViewOutcomingCell", bundle: nil)
        tableView.register(outcomingNibName, forCellReuseIdentifier: "chatOutcomingCell")
        
        let incomingNibName = UINib(nibName: "UIChatTableViewIncomingCell", bundle: nil)
        tableView.register(incomingNibName, forCellReuseIdentifier: "chatIncomingCell")
        
        // Setup textfield
        let chatTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30.00));
        chatTextField.center = self.view.center
        chatTextField.placeholder = "Place holder text"
        chatTextField.borderStyle = UITextBorderStyle.line
        chatTextField.backgroundColor = UIColor.lightGray
        chatTextField.textColor = UIColor.black
        tableView.tableFooterView = chatTextField
        chatTextField.delegate = self
        
    }
    
    
    func updateData() {
        let lastPath = NSIndexPath(row: messages.count - 1 , section: 0)
        tableView.insertRows(at: [lastPath as IndexPath], with: .automatic)
    }
    
    override func viewDidLayoutSubviews() {
        if !isPrintingNow {
            updateTableContentInset()
        }
    }
}


// MARK: - Table view Data Source

extension UIChatTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch messages[indexPath.row].type {
            
        case .incoming:
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatIncomingCell", for: indexPath) as! UIChatTableViewIncomingCell
            cell.configure(withMessage: messages[indexPath.row])
            return cell
            
        case .outcoming:
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatOutcomingCell", for: indexPath) as! UIChatTableViewOutcomingCell
            cell.configure(withMessage: messages[indexPath.row])
            return cell
        default:break
        }
    }
    
}


// MARK: - Chat protocol

extension UIChatTableViewController : ChatProtocol {
    
    func addMessage(message: String, type: ChatMessageType) {
        let chatMessage = ChatMessage(time: Helper.currentTime(), message: message, type: type)
        self.messages.append(chatMessage)
    }
    
    func sendMessage(message: String, type: ChatMessageType) {
        let chatMessage = ChatMessage(time: Helper.currentTime(), message: message, type: type)
        udpManager?.sendMessage(message: chatMessage.message)
    }
    
}


// MARK: - Support function

extension UIChatTableViewController {
    
    func updateTableContentInset() {
        let numRows = tableView(tableView, numberOfRowsInSection: 0)
        var contentInsetTop = self.tableView.bounds.size.height
        for i in 0 ..< numRows {
            contentInsetTop -= tableView(tableView, heightForRowAt: IndexPath(item: i, section: 0))
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
        }
        tableView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0)
        scrollToBottom()
    }
    
    func scrollToBottom(){
        tableView.scrollRectToVisible((tableView.tableFooterView?.frame)!, animated: false)
    }
}


// MARK: - Text field delegate
extension UIChatTableViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isPrintingNow = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isPrintingNow = false
        if let text = textField.text {
            self.addMessage(message: text, type: .outcoming)
            self.sendMessage(message: text, type: .outcoming)
            
        }
        tableView.endEditing(true)
        textField.text = ""
        return true
    }
}

extension UIChatTableViewController: UDPManagerDelegate {
    func receiveMessage(message: String) {
        self.addMessage(message: message, type: .incoming)
    }
}
