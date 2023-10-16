//
//  Model.swift
//  DataPersistCoreData
//
//  Created by Nicky Taylor on 1/30/23.
//

import Foundation
import CoreData

class Model {
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Database")
    }
    
    func loadPersistentStores() async {
        await withCheckedContinuation { continuation in
            container.loadPersistentStores { description, error in
                continuation.resume()
            }
        }
    }
    
    func loadSavedTexts() async -> [SavedText] {
        let context = container.viewContext
        var result = [SavedText]()
        await context.perform {
            let fetchRequest = SavedText.fetchRequest()
            do {
                result = try context.fetch(fetchRequest)
            } catch let error {
                print("LoadSavedTextsError: \(error.localizedDescription)")
            }
        }
        return result
    }
    
    func saveData(dataString: String) async {
        let context = container.viewContext
        let savedTexts = await loadSavedTexts()
        
        await context.perform {
            if savedTexts.count > 0 {
                savedTexts[0].text = dataString
            } else {
                let savedText = SavedText(context: context)
                savedText.text = dataString
            }
            
            do {
                try context.save()
            } catch let error {
                print("WriteSavedTextsError: \(error.localizedDescription)")
            }
        }
    }
    
    func loadData() async -> String? {
        let savedTexts = await loadSavedTexts()
        if savedTexts.count > 0 {
            return savedTexts[0].text
        }
        return nil
    }
}
