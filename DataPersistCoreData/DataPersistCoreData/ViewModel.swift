//
//  ViewModel.swift
//  DataPersistCoreData
//
//  Created by Nicky Taylor on 1/30/23.
//

import Foundation

class ViewModel: ObservableObject {
    
    let model = Model()
    
    init() {
        
        syncDataModel()
    }
    
    // Only called on init...
    private func syncDataModel() {
        Task {
            await model.loadPersistentStores()
            
        }
    }
    
    func saveDataIntent(dataString: String) async {
        await model.saveData(dataString: dataString)
    }
    
    func loadDataIntent() async -> String? {
        return await model.loadData()
    }
    
    
}
