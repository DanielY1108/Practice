//
//  DataManager.swift
//  Table
//
//  Created by JinSeok Yang on 2022/10/14.
//

import Foundation
import UIKit


class DataManager {
    private var cityDataArray: [City] = []
    
    func makeCityData() {
        for x in 0..<9 {
            cityDataArray.append(City(cityImage: UIImage(named: "download-\(x+1)"), description: "이런건가 \(x)"))

        }
    }
    
    func getCityData() -> [City] {
        return cityDataArray
    }
    
    func updateCityData() {
        let city = cityDataArray.randomElement()
        cityDataArray.append(city!)
    }
    
    
}
