//
//  HomeViewController.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 13.08.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    //UI Elements
    private let jarImageView = UIImageView()
    private let addMemoryButton = UIButton()
    private let memoryCountLabel = UILabel()
    private let randomMemoryButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()

        // Do any additional setup after loading the view.
    }
    
    private func setupUI(){
        view.backgroundColor = .systemBackground
        jarImageView.image = UIImage(systemName:"archivebox.fill")
        jarImageView.tintColor = .systemBlue
        jarImageView.contentMode = .scaleAspectFit
        
        //TODO : buttonları setup edicez
        addMemoryButton.setTitle("Yeni Anı Ekle✨", for: .normal)
        addMemoryButton.backgroundColor = .systemBlue
        addMemoryButton.layer.cornerRadius = 12
        addMemoryButton.setTitleColor(.white, for: .normal)
        
        randomMemoryButton.setTitle("Rastgele Anı", for: .normal)
        randomMemoryButton.backgroundColor = .clear
        randomMemoryButton.setTitleColor(.systemBlue, for: .normal)
        randomMemoryButton.layer.cornerRadius = 12
        randomMemoryButton.layer.borderWidth = 1
        randomMemoryButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        memoryCountLabel.text = "5 güzel anın var"
        memoryCountLabel.textAlignment = .center
        memoryCountLabel.textColor = .secondaryLabel
        
        
    }
    
    private func setupLayout() {
        // Auto Layout için
        [jarImageView, addMemoryButton, randomMemoryButton, memoryCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // Kavanoz ortada üstte
            jarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            jarImageView.widthAnchor.constraint(equalToConstant: 120),
            jarImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Memory count kavanozun altında
            memoryCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            memoryCountLabel.topAnchor.constraint(equalTo: jarImageView.bottomAnchor, constant: 20),
            
            // Add button
            addMemoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addMemoryButton.topAnchor.constraint(equalTo: memoryCountLabel.bottomAnchor, constant: 40),
            addMemoryButton.widthAnchor.constraint(equalToConstant: 250),
            addMemoryButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Random button
            randomMemoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomMemoryButton.topAnchor.constraint(equalTo: addMemoryButton.bottomAnchor, constant: 16),
            randomMemoryButton.widthAnchor.constraint(equalToConstant: 250),
            randomMemoryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
