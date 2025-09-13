//
//  HomeViewController.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 13.08.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Ana renk paleti (bal teması)
    let primaryHoney = UIColor(hex: "#FFA726")    // Ana bal rengi
    let lightHoney = UIColor(hex: "#FFD54F")      // Açık bal
    let darkHoney = UIColor(hex: "#FF8F00")       // Koyu bal
    
    
    //UI Elements
    private let jarImageView = UIImageView()//iconla güncellenecek
    private let addMemoryButton = UIButton()
   
    private let randomMemoryButton = UIButton()
    
    private let welcomeCardView = UIView()
    private let welcomeLabel = UILabel()
    
    // Gradient Layer oluştur
    let gradientLayer = CAGradientLayer()
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()

        // Do any additional setup after loading the view.
    }
    
    private func setupUI(){
        // Bal temasına uygun soft background
        view.backgroundColor = UIColor(hex: "#FFF8E1")  // 🔄 Krem rengi (creamHoney)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Memory Jar"
        
        
        jarImageView.image = UIImage(named:"jar")
        jarImageView.contentMode = .scaleAspectFit
        
        //TODO : buttonları setup edicez
        addMemoryButton.setTitle("Add new memory✨", for: .normal)
        addMemoryButton.backgroundColor = primaryHoney  // 🔄 Bal rengi
        addMemoryButton.layer.cornerRadius = 12
        addMemoryButton.setTitleColor(.white, for: .normal)
        addMemoryButton.addTarget(self, action: #selector(addMemoryTapped), for: .touchUpInside)
        
        randomMemoryButton.setTitle("Random memory", for: .normal)
        randomMemoryButton.backgroundColor = .clear
        randomMemoryButton.setTitleColor(darkHoney, for: .normal)    // 🔄 Koyu bal
        randomMemoryButton.layer.cornerRadius = 12
        randomMemoryButton.layer.borderWidth = 1
        randomMemoryButton.layer.borderColor = darkHoney.cgColor    // 🔄 Koyu bal border
        
     
        
        
        welcomeCardView.layer.cornerRadius = 12
        welcomeCardView.layer.shadowColor = UIColor.black.cgColor
        welcomeCardView.layer.shadowOpacity = 0.1
        welcomeCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // Gradient ekle
        DispatchQueue.main.async {
            self.welcomeCardView.addGradient(colors: [
                UIColor(red: 0.98, green: 0.87, blue: 0.65, alpha: 1.0),  // Açık bal
                UIColor(red: 0.85, green: 0.92, blue: 0.98, alpha: 1.0)   // Açık mavi
            ])
        }

        
        welcomeLabel.text = "Welcome Tuna! \nAre you ready to add new good memories?"
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .left
        welcomeLabel.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        welcomeLabel.textColor = UIColor(red: 0.2, green: 0.3, blue: 0.4, alpha: 1.0) // Koyu gri-mavi
        
        
    }
    
    private func setupLayout() {
        // Auto Layout için - ✨ Welcome card elementlerini de ekle
        [jarImageView, addMemoryButton, randomMemoryButton, welcomeCardView, welcomeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        // Welcome card'ı label'ın parent'ı yap
        welcomeCardView.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            // Welcome Card (navigation'ın altında)
            // Welcome Card (title ile aynı hizada ve daha geniş)
            welcomeCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5), // 🔄 20'den 5'e
            welcomeCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),           // 🔄 20'den 12'ye
            welcomeCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),       // 🔄 -20'den -12'ye
            welcomeCardView.heightAnchor.constraint(equalToConstant: 80),
            
            // Welcome Label (card'ın içinde)
            welcomeLabel.centerXAnchor.constraint(equalTo: welcomeCardView.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: welcomeCardView.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: welcomeCardView.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: welcomeCardView.trailingAnchor, constant: -16),
            
            // Kavanoz welcome card'ın altında - BÜYÜK
            jarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jarImageView.topAnchor.constraint(equalTo: welcomeCardView.bottomAnchor, constant: 40),
            jarImageView.widthAnchor.constraint(equalToConstant: 190),   // 🔄 120'den 180'e
            jarImageView.heightAnchor.constraint(equalToConstant: 190),  // 🔄 120'den 180'e
            
           
            
            addMemoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addMemoryButton.topAnchor.constraint(equalTo: jarImageView.bottomAnchor, constant: 80), // 🔄 40'tan 60'a (daha aşağı)
            addMemoryButton.widthAnchor.constraint(equalToConstant: 250), // 🔧 Bu satır eksikti!
            addMemoryButton.heightAnchor.constraint(equalToConstant: 50),
            
            randomMemoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomMemoryButton.topAnchor.constraint(equalTo: addMemoryButton.bottomAnchor, constant: 16),
            randomMemoryButton.widthAnchor.constraint(equalToConstant: 250),
            randomMemoryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    
    @objc private func addMemoryTapped(){
        print("add memory butnonua tıklandı ")
        
        let addMemoryVC = AddMemoryViewController()
        //navigation controllere wrap ediyorum cancel save butonlari için
        let navController = UINavigationController(rootViewController: addMemoryVC)
        //sheetle veriyoruz
        
        navController.modalPresentationStyle = .pageSheet
        
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.large()] //full height
            sheet.prefersGrabberVisible = true // üstte cizgi
            
        }
        
        present(navController,animated: true)
        
    }
    

}



extension UIView {
    func addGradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex.hasPrefix("#") ? String(hex.dropFirst()) : hex)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let red = Double((color & 0xFF0000) >> 16) / 255.0
        let green = Double((color & 0x00FF00) >> 8) / 255.0
        let blue = Double(color & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
