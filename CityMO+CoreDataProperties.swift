//
//  CityMO+CoreDataProperties.swift
//  weatherForecast
//
//  Created by 王煜 on 2016/11/29.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import Foundation
import CoreData


extension CityMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityMO> {
        return NSFetchRequest<CityMO>(entityName: "CityMO");
    }

    @NSManaged public var cityNum: String?
    @NSManaged public var cityName: String?
    @NSManaged public var weaid: String?
    @NSManaged public var days: String?
    @NSManaged public var week: String?
    @NSManaged public var cityno: String?
    @NSManaged public var cityid: Int64
    @NSManaged public var temperature: String?
    @NSManaged public var temperature_curr: String?
    @NSManaged public var humidity: String?
    @NSManaged public var weather: String?
    @NSManaged public var wind: String?
    @NSManaged public var winp: String?
    @NSManaged public var temp_high: Int64
    @NSManaged public var temp_low: Int64
    @NSManaged public var temp_curr: Int64
    

}
