//
//  SettingsViewModel.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 27.02.2026.
//

import Foundation

class SettingsViewModel {
    
    enum SettingSection: Int, CaseIterable {
        case general
        case data
        
        var title: String? {
            switch self {
            case .general: return "General"
            case .data: return "Data Management"
            }
        }
    }
    
    enum DataOption: Int, CaseIterable {
        case clearJar
        
        var title: String {
            switch self {
            case .clearJar: return "Clear the Jar"
            }
        }
        
        var icon: String {
            switch self {
            case .clearJar: return "trash.fill"
            }
        }
    }
    
    // MARK: - Callbacks
    var onJarCleared: (() -> Void)?
    var onClearError: (() -> Void)?
    
    // MARK: - TableView Helpers
    var numberOfSections: Int {
        return SettingSection.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch SettingSection(rawValue: section) {
        case .general: return 1
        case .data: return DataOption.allCases.count
        default: return 0
        }
    }
    
    func titleForHeader(in section: Int) -> String? {
        return SettingSection(rawValue: section)?.title
    }
    
    // MARK: - Actions
    func clearJar() {
        if CoreDataManager.shared.deleteAllMemories() {
            onJarCleared?()
        } else {
            onClearError?()
        }
    }
}
