//
//  BrowerViewController.swift
//  SipmleBrower
//
//  Created by lelya.rumynin@gmail.com on 16.08.23.
//

import UIKit
import WebKit

class BrowerViewController: UIViewController {
    @IBOutlet weak var webKit: WKWebView!
    
    @IBOutlet weak var search: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self
        generateURL(search.text)
        
        setupTextField()
        setupKeyboard()
    }
    
    @IBAction func back(_ sender: Any) {
        webKit.goBack()
    }
    
    @IBAction func forward(_ sender: Any) {
        webKit.goForward()
    }
    
    @IBAction func refrash(_ sender: Any) {
        webKit.reload()
    }
    
    
    
    func generateURL(_ urlString: String?){
        
        guard var urlString else {
            print("you dont have URL")
            return
        }
        
        if !urlString.starts(with: "http://") || !urlString.starts(with: "https://"){
            urlString = "https://" + urlString
        }
        
        guard let URL = URL(string: urlString) else {
            print("wrong URl")
            return
        }
        let request = URLRequest(url: URL)
        webKit.load(request)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    @objc
    private func keyboardWillAppear(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        
        bottomConstraint.constant = keyboardHeight
    }
    
    @objc
    private func keyboardWillDisappear(notification: NSNotification) {
        bottomConstraint.constant = 16
        view.layoutIfNeeded()
    }
    
    private func setupTextField() {
        search.delegate = self
        search.text = "https://apple.com"
        generateURL(search.text)
    }
    
}

extension BrowerViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        generateURL(textField.text)
        return true
    }
    
}
