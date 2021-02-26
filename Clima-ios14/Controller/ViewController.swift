//
//  ViewController.swift
//  Clima-ios14
//
//  Created by 程式猿 on 2021/2/26.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var searchTextFiled: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextFiled.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextFiled.endEditing(true)
        print(searchTextFiled.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFiled.endEditing(true)
        print(searchTextFiled.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextFiled.text != "" {
            return true
        } else {
            searchTextFiled.placeholder = "打些什麼吧"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextFiled.text = ""
    }
    
}

