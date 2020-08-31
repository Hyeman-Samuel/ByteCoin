//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyAbreveation: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    var coinManager = CoinManager();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
        coinManager.delegate=self
    }
    
       
  
}









//MARK: -EXCHANGE RATE DELEGATE


extension ViewController : ExchangeRateDelegate {
    
    func SetExchangeRateData(coinManager: CoinManager, exchangeData: ExchangeRate?) {
          if let Data = exchangeData{
          DispatchQueue.main.async {
              self.currencyValue.text  = String(format:"%.2f",Data.rate);
              }
          }
      }
}















//MARK: -UIPICKER DATASOURCE

extension ViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
}










//MARK: -UIPICKER DELEGATE

extension ViewController :  UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedItem =  coinManager.currencyArray[row]
        currencyAbreveation.text = selectedItem;
        currencyValue.text = "...";
        coinManager.GetCurrencyValue(currency: selectedItem)
    }
}

