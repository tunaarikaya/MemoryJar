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
    private let calendarView = UICalendarView()
    
    private var allMemories: [Memory] = []
    private var filteredMemories: [Memory] = []
    private var selectedDate: DateComponents?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        
        // Varsayılan olarak bugünü seç
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        selectedDate = today
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMemories()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFF8E1")
        title = "Timeline"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Calendar Setup
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.tintColor = UIColor(hex: "#FF8F00")
        calendarView.backgroundColor = .white.withAlphaComponent(0.5)
        calendarView.layer.cornerRadius = 20
        calendarView.clipsToBounds = true
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        
        // TableView Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MemoryCell.self, forCellReuseIdentifier: "MemoryCell")
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
    }
    
    private func setupLayout() {
        [calendarView, tableView].forEach { view.addSubview($0) }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func fetchMemories() {
        allMemories = CoreDataManager.shared.fetchAllMemories().sorted(by: { ($0.date ?? Date()) > ($1.date ?? Date()) })
        filterMemories()
    }
    
    private func filterMemories() {
        guard let selectedDate = selectedDate else {
            filteredMemories = allMemories
            tableView.reloadData()
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
        
        tableView.reloadData()
    }
}

extension MemoriesViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        self.selectedDate = dateComponents
        filterMemories()
    }
}

extension MemoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredMemories.isEmpty {
            showEmptyState()
        } else {
            tableView.backgroundView = nil
        }
        return filteredMemories.count
    }
    
    private func showEmptyState() {
        let emptyLabel = UILabel()
        emptyLabel.text = "No memories for this day 🍯"
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = UIColor(hex: "#C4976C")
        emptyLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tableView.backgroundView = emptyLabel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell", for: indexPath) as! MemoryCell
        let memory = filteredMemories[indexPath.row]
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
