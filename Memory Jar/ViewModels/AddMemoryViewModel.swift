//
//  AddMemoryViewModel.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 27.02.2026.
//

import UIKit

class AddMemoryViewModel {
    
    // MARK: - Callbacks
    var onSaveSuccess: (() -> Void)?
    var onSaveFailure: ((String) -> Void)?
    
    // MARK: - Actions
    func saveMemory(text: String?, date: Date, image: UIImage?) {
        guard let text = text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            onSaveFailure?("Please write something to save your memory!")
            return
        }
        
        let success = CoreDataManager.shared.saveMemory(
            text: text,
            date: date,
            image: image
        )
        
        if success {
            onSaveSuccess?()
        } else {
            onSaveFailure?("Could not save memory. Please try again.")
        }
    }
}
