//
//  SettingsViewController.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 27.02.2026.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFF8E1")
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func clearJar() {
        let alert = UIAlertController(title: "Clear the Jar?", message: "This will permanently delete all your memories. Are you sure?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete Everything", style: .destructive) { _ in
            if CoreDataManager.shared.deleteAllMemories() {
                let successAlert = UIAlertController(title: "Jar Cleared", message: "Your jar is now empty and ready for new memories!", preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(successAlert, animated: true)
            }
        })
        
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SettingSection(rawValue: section) {
        case .general: return 1
        case .data: return DataOption.allCases.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingSection(rawValue: section)?.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        switch SettingSection(rawValue: indexPath.section) {
        case .general:
            cell.textLabel?.text = "About Memory Jar"
            cell.imageView?.image = UIImage(systemName: "info.circle.fill")
            cell.imageView?.tintColor = UIColor(hex: "#FF8F00")
            cell.accessoryType = .disclosureIndicator
        case .data:
            let option = DataOption(rawValue: indexPath.row)
            cell.textLabel?.text = option?.title
            cell.textLabel?.textColor = .systemRed
            cell.imageView?.image = UIImage(systemName: option?.icon ?? "")
            cell.imageView?.tintColor = .systemRed
            cell.accessoryType = .none
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch SettingSection(rawValue: indexPath.section) {
        case .general:
            let alert = UIAlertController(title: "Memory Jar", message: "Created with ❤️ by Tuna Arıkaya\nVersion 1.0", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cool!", style: .default))
            present(alert, animated: true)
        case .data:
            if DataOption(rawValue: indexPath.row) == .clearJar {
                clearJar()
            }
        default: break
        }
    }
}
