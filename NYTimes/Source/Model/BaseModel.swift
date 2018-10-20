//
//  BaseModel.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import Foundation

protocol BaseModel {
    
    static func createInstanceFromDictionary(_ dictionary: [String: Any]?) -> Any?
    static func createInstanceFromData(_ data: Data) -> Any?
    static func createInstanceFromFile(_ fileName: String) -> Any?
    
    static func arrayFromData(_ data: Data) -> [Any]?
    static func arrayFromFile(_ fileName: String) -> [Any]?
    
    func dictionaryRepresentation() -> [String: Any]?
    func setAttributesFromDictionary(_ dictionary: [String: Any]?)
}

extension BaseModel {
    
    static func createInstanceFromData(_ data: Data) -> Any? {
        if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            return createInstanceFromDictionary(jsonDict)
        }
        return nil
    }
    
    static func createInstanceFromFile(_ fileName: String) -> Any? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return createInstanceFromData(data)
            }
        }
        return nil
    }
    
    static func arrayFromData(_ data: Data) -> [Any]? {
        
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            if let jsonArray = jsonObject as? [Any] {
                var objectCollection: [Any] = [Any]()
                for jsonDict in jsonArray {
                    if let dict = jsonDict as? [String: Any] {
                        objectCollection.append(createInstanceFromDictionary(dict)!)
                    }
                }
                return objectCollection
            }
        }
        return nil
    }
    
    static func arrayFromFile(_ fileName: String) -> [Any]? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return arrayFromData(data)
            }
        }
        return nil
    }
    
    func listFromRawArray<T: BaseModel>(_ listArray:[Any]?) -> [T]? {
        guard listArray != nil else { return nil }
        var itemList = [T]()
        for (element) in listArray! {
            let instance = T.createInstanceFromDictionary(element as? [String : Any]) as? T
            if instance != nil {
                itemList.append(instance!)
            }
        }
        return itemList
    }
}
