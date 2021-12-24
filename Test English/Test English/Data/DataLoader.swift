//
//  DataLoader.swift
//  Test English
//
//  Created by Vu Thanh on 20/12/2021.
//

import Foundation

public class DataLoader{
    @Published var wordData = [Word]()
    
    init(){
        load()
    }
    
    func load(){
        if let fileLocation = Bundle.main.url(forResource: "words", withExtension: "json"){
            // do catch in case of the error
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let datafromJson = try jsonDecoder.decode([Word].self, from: data)
                
                self.wordData = datafromJson
            } catch {
                print(error)
            }
            
        }
    }
}

