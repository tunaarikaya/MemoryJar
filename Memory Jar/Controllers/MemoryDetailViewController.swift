//
//  MemoryDetailViewController.swift
//  Memory Jar
//
//  Created by Antigravity on 27.02.2026.
//

import UIKit
import SnapKit

class MemoryDetailViewController: UIViewController {
    
    private let memory: Memory
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = UIImageView()
    private let dateLabel = UILabel()
    private let textView = UITextView()
    
    init(memory: Memory) {
        self.memory = memory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        configureData()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFF8E1")
        title = "A Memory ✨"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeTapped))
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = UIColor(hex: "#F8F6F0")
        
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        dateLabel.textColor = UIColor(hex: "#FF8F00")
        dateLabel.textAlignment = .center
        
        textView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textView.textColor = UIColor(red: 0.2, green: 0.3, blue: 0.4, alpha: 1.0)
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [imageView, dateLabel, textView].forEach { contentView.addSubview($0) }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(imageView.snp.width)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    private func configureData() {
        if let imageData = memory.imageData {
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.image = UIImage(named: "placeholder") // Fallback
            imageView.contentMode = .center
            imageView.tintColor = UIColor(hex: "#E8DCC6")
        }
        
        if let date = memory.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            dateLabel.text = formatter.string(from: date).uppercased()
        }
        
        textView.text = memory.text
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}
