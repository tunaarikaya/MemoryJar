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
    private let viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.onJarCleared = { [weak self] in
            let successAlert = UIAlertController(title: "Jar Cleared", message: "Your jar is now empty and ready for new memories!", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(successAlert, animated: true)
        }
        
        viewModel.onClearError = { [weak self] in
            let alert = UIAlertController(title: "Error", message: "Failed to clear the jar.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
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
        alert.addAction(UIAlertAction(title: "Delete Everything", style: .destructive) { [weak self] _ in
            self?.viewModel.clearJar()
        })
        
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "About Memory Jar"
            cell.imageView?.image = UIImage(systemName: "info.circle.fill")
            cell.imageView?.tintColor = UIColor(hex: "#FF8F00")
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.section == 1 {
            let option = SettingsViewModel.DataOption(rawValue: indexPath.row)
            cell.textLabel?.text = option?.title
            cell.textLabel?.textColor = .systemRed
            cell.imageView?.image = UIImage(systemName: option?.icon ?? "")
            cell.imageView?.tintColor = .systemRed
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let alert = UIAlertController(title: "Memory Jar", message: "Created with ❤️ by Tuna Arıkaya\nVersion 1.0", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cool!", style: .default))
            present(alert, animated: true)
        } else if indexPath.section == 1 {
            if SettingsViewModel.DataOption(rawValue: indexPath.row) == .clearJar {
                clearJar()
            }
        }
    }
}
