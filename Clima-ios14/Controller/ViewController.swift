//
//  ViewController.swift
//  Clima-ios14
//
//  Created by 程式猿 on 2021/2/26.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, WeatherManergerDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var searchTextFiled: UITextField!
    
    var weatherManerger = WeatherManerger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManerger.delegate = self
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
        if let city = searchTextFiled.text {
            weatherManerger.fetchWeather(cityName: city)
        }
        searchTextFiled.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        let name = weather.cityName
        print(name)
    }
    
}

