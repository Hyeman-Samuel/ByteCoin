//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5E846F70-EF6E-4B67-80C9-7A98DAE8D064"
    var delegate:ExchangeRateDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func GetCurrencyValue(currency : String){
        let ModifiedBaseUrl = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        if let Url = URL(string: ModifiedBaseUrl){
            let Session = URLSession(configuration: .default)
           let myTask = Session.dataTask(with: Url) { (data, response, error) in
            if let SafeData = data{
                let Rate = self.ParseJson(SafeData);
                self.delegate?.SetExchangeRateData(coinManager: self, exchangeData: Rate)
            }
            }
            myTask.resume()
        }
    }
    
    func ParseJson(_ data:Data) -> ExchangeRate?{
        let decoder = JSONDecoder()
            do {
                let Rate = try decoder.decode(ExchangeRate.self, from: data)
                return Rate
               } catch {
                print(error)
               }
       return nil
        
    }
}


struct ExchangeRate : Decodable {
    var rate : Double
    var asset_id_quote : String
}

protocol ExchangeRateDelegate {
    func SetExchangeRateData(coinManager:CoinManager,exchangeData:ExchangeRate?)
}
