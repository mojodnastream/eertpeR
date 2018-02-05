//
//  Helpers.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import Foundation

class utils {
    
    //SAVE THIS
//    struct Location {
//        let title: String
//        let latitude: Double
//        let longitude: Double
//    }
//    
//    let locations = [
//        Location(title: "New York, NY",    latitude: 40.713054, longitude: -74.007228),
//        Location(title: "Los Angeles, CA", latitude: 34.052238, longitude: -118.243344),
//        Location(title: "Chicago, IL",     latitude: 41.883229, longitude: -87.632398)
//    ]
    
//    for location in locations {
//    let annotation = MKPointAnnotation()
//    annotation.title = location.title
//    annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//    mapView.addAnnotation(annotation)
//    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func getInitials(theName: String) -> String {
        let initials = theName.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        return initials
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.range(of: emailRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    static func getResultType(arrayString:String) -> String {
        let index = arrayString.indexDistance(of: "~")
        let result = arrayString.substring(start: 0,end: index!)
        return result
    }
    
    static func getResultName(arrayString:String) -> String {
        var index = arrayString.indexDistance(of: "~")
        let theEnd = arrayString.indexDistance(of: "*")
        index = index! + 1
        let theResult = arrayString.substring(start:index!,end: theEnd!)
        //theResult = theResult.remove(at: theResult.startIndex)
        return theResult
    }
    
    static func getResultID(arrayString:String) -> String {
        var index = arrayString.indexDistance(of: "*")
        let theEnd = arrayString.indexDistance(of: "^")
        index = index! + 1
        let theResult = arrayString.substring(start:index!,end: theEnd!)
        return theResult
    }
    static func getResultTail(arrayString:String) -> String {
        var index = arrayString.indexDistance(of: "^")
        index = index! + 1
        let theResult = arrayString.substring(start:index!,end: arrayString.count)
        return theResult
    }
    static func getResultFollowID(arrayString:String) -> String {
        //var index = arrayString.indexDistance(of: "*")
        let theEnd = arrayString.indexDistance(of: "*")
        //index = index! + 1
        let theResult = arrayString.substring(start:0,end: theEnd!)
        return theResult
    }
    static func getResultNumber(arrayString:String) -> Int {
        var index = arrayString.indexDistance(of: "*")
        index = index! + 1
        let theResult = Int(arrayString.substring(start:index!,end: arrayString.count))
        return theResult!
    }
}
extension String {
    func indexDistance(of character: Character) -> Int? {
        guard let index = index(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
    func substring(start: Int, end: Int) -> String {
        if (start == end || self.strlen() == 0) {
            return ""
        }
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }

    func strlen() -> Int {
        return self.count
    }
}

//
//extension String {
//    func index(of string: String, options: CompareOptions = .literal) -> Index? {
//        return range(of: string, options: options)?.lowerBound
//    }
//    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
//        return range(of: string, options: options)?.upperBound
//    }
//    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
//        var result: [Index] = []
//        var start = startIndex
//        while let range = range(of: string, options: options, range: start..<endIndex) {
//            result.append(range.lowerBound)
//            start = range.upperBound
//        }
//        return result
//    }
//    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
//        var result: [Range<Index>] = []
//        var start = startIndex
//        while let range = range(of: string, options: options, range: start..<endIndex) {
//            result.append(range)
//            start = range.upperBound
//        }
//        return result
//    }
//}

