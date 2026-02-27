//
//  CoreDataManager.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 27.02.2026.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func saveMemory(text: String, date: Date, image: UIImage?) -> Bool {
        let memory = Memory(context: context)
        memory.id = UUID()
        memory.text = text
        memory.date = date
        
        if let image = image {
            memory.imageData = image.jpegData(compressionQuality: 0.8)
        }
        
        do {
            try context.save()
            return true
        } catch {
            print("Error saving memory: \(error)")
            return false
        }
    }
    
    func fetchAllMemories() -> [Memory] {
        let fetchRequest: NSFetchRequest<Memory> = Memory.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching memories: \(error)")
            return []
        }
    }
    
    func fetchRandomMemory() -> Memory? {
        let memories = fetchAllMemories()
        return memories.randomElement()
    }
}
