//
//  MemoriesViewController.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 27.02.2026.
//

import UIKit
import SnapKit

class MemoriesViewController: UIViewController {
    
    private let tableView = UITableView()
    private var memories: [Memory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMemories()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFF8E1")
        title = "All Memories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MemoryCell.self, forCellReuseIdentifier: "MemoryCell")
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func fetchMemories() {
        memories = CoreDataManager.shared.fetchAllMemories().sorted(by: { ($0.date ?? Date()) > ($1.date ?? Date()) })
        tableView.reloadData()
    }
}

extension MemoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell", for: indexPath) as! MemoryCell
        let memory = memories[indexPath.row]
        cell.configure(with: memory)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memory = memories[indexPath.row]
        let detailVC = MemoryDetailViewController(memory: memory)
        let navController = UINavigationController(rootViewController: detailVC)
        present(navController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class MemoryCell: UITableViewCell {
    private let containerView = UIView()
    private let memoryImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.05
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        memoryImageView.contentMode = .scaleAspectFill
        memoryImageView.clipsToBounds = true
        memoryImageView.layer.cornerRadius = 8
        memoryImageView.backgroundColor = UIColor(hex: "#F8F6F0")
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.3, blue: 0.4, alpha: 1.0)
        
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        dateLabel.textColor = UIColor(hex: "#FF8F00")
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        [memoryImageView, titleLabel, dateLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        memoryImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(memoryImageView.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(memoryImageView.snp.trailing).offset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(with memory: Memory) {
        titleLabel.text = memory.text
        
        if let date = memory.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            dateLabel.text = formatter.string(from: date)
        }
        
        if let imageData = memory.imageData {
            memoryImageView.image = UIImage(data: imageData)
        } else {
            memoryImageView.image = UIImage(systemName: "photo")
            memoryImageView.tintColor = UIColor(hex: "#E8DCC6")
            memoryImageView.contentMode = .center
        }
    }
}
