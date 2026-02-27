//
//  HomeViewModel.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 27.02.2026.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Callbacks
    var onShowRandomMemory: ((Memory) -> Void)?
    var onEmptyJar: (() -> Void)?
    
    // MARK: - Actions
    func pullRandomMemory() {
        if let randomMemory = CoreDataManager.shared.fetchRandomMemory() {
            onShowRandomMemory?(randomMemory)
        } else {
            onEmptyJar?()
        }
    }
}
