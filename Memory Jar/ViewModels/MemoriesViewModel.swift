//
//  MemoriesViewModel.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 27.02.2026.
//

import Foundation

class MemoriesViewModel {
    
    // MARK: - Properties
    private var allMemories: [Memory] = []
    
    private(set) var filteredMemories: [Memory] = [] {
        didSet {
            onDataUpdated?()
        }
    }
    
    var selectedDate: DateComponents? {
        didSet {
            filterMemories()
        }
    }
    
    // MARK: - Callbacks
    var onDataUpdated: (() -> Void)?
    
    // MARK: - Init
    init() {
        // Set today as default
        self.selectedDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    }
    
    // MARK: - Data Fetching
    func fetchMemories() {
        allMemories = CoreDataManager.shared.fetchAllMemories().sorted(by: { ($0.date ?? Date()) > ($1.date ?? Date()) })
        filterMemories()
    }
    
    private func filterMemories() {
        guard let selectedDate = selectedDate else {
            filteredMemories = allMemories
            return
        }
        
        let calendar = Calendar.current
        filteredMemories = allMemories.filter { memory in
            guard let date = memory.date else { return false }
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            return components.year == selectedDate.year &&
                   components.month == selectedDate.month &&
                   components.day == selectedDate.day
        }
    }
    
    // MARK: - TableView Helpers
    var numberOfRows: Int {
        return filteredMemories.count
    }
    
    func memory(at index: Int) -> Memory {
        return filteredMemories[index]
    }
}
