//
//  AddMemoryViewController.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 14.08.2025.
//

import UIKit
import SnapKit

class AddMemoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let imageContainerView = UIView()
    private let memoryImageView = UIImageView()
    private let cameraIconView = UIImageView()
    private let placeholderLabel = UILabel()
    
    private let memoryTextView = UITextView()
    private let guidanceLabel = UILabel()
    private let datePicker = UIDatePicker() // ✨ Sadece datePicker kaldı
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let viewModel = AddMemoryViewModel()
    
    private var imageContainerHeightConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
        setupLayout()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.onSaveSuccess = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        viewModel.onSaveFailure = { [weak self] message in
            let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    private func setupNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "New Memory"
    }
  
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFF8E1")
        
        imageContainerView.backgroundColor = UIColor(hex: "#F8F6F0")
        imageContainerView.layer.cornerRadius = 12
        imageContainerView.layer.borderWidth = 2
        imageContainerView.layer.borderColor = UIColor(hex: "#E8DCC6").cgColor
        
        // Camera icon
        cameraIconView.image = UIImage(systemName: "camera.fill")
        cameraIconView.tintColor = UIColor(hex: "#C4976C")
        cameraIconView.contentMode = .scaleAspectFit
        
        // Placeholder label
        placeholderLabel.text = "Tap to add photo!"
        placeholderLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        placeholderLabel.textColor = UIColor(hex: "#C4976C")
        placeholderLabel.textAlignment = .center
        
        // Memory text view
        memoryTextView.font = UIFont.systemFont(ofSize: 16)
        memoryTextView.backgroundColor = .white
        memoryTextView.layer.cornerRadius = 12
        memoryTextView.layer.borderWidth = 1
        memoryTextView.layer.borderColor = UIColor(hex: "#E8DCC6").cgColor
        memoryTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        // Guidance label
        guidanceLabel.text = "We recommended write 3 sentences max\nfor pure minimalist vibes ✨"
        guidanceLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        guidanceLabel.textColor = UIColor(hex: "#C4976C")
        guidanceLabel.textAlignment = .center
        guidanceLabel.numberOfLines = 2
        
        // Date picker setup ✨
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date()
        datePicker.date = Date() // Default bugün
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        // Tap gesture for image container
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageContainerTapped))
        imageContainerView.addGestureRecognizer(tapGesture)
        imageContainerView.isUserInteractionEnabled = true
    }
    
    private func setupLayout() {
        // ScrollView ana view'a ekle
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Content elementlerini contentView'a ekle
        [imageContainerView, memoryTextView, guidanceLabel, datePicker].forEach {
            contentView.addSubview($0)
        }
        
        // Image container'ın içindeki elementler
        [cameraIconView, placeholderLabel, memoryImageView].forEach {
            imageContainerView.addSubview($0)
        }
        
        // ScrollView constraint'leri
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // ContentView constraint'leri
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // Image Container constraints
        imageContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            imageContainerHeightConstraint = make.height.equalTo(180).constraint
        }
        
        // Camera Icon constraints
        cameraIconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
        
        // Placeholder Label constraints
        placeholderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cameraIconView.snp.bottom).offset(8)
        }
        
        // Memory Image constraints
        memoryImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        // Memory TextView constraints
        memoryTextView.snp.makeConstraints { make in
            make.top.equalTo(imageContainerView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        // Guidance Label constraints
        guidanceLabel.snp.makeConstraints { make in
            make.top.equalTo(memoryTextView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Date Picker constraints ✨
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(guidanceLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        viewModel.saveMemory(
            text: memoryTextView.text,
            date: datePicker.date,
            image: memoryImageView.image
        )
    }
    
    @objc private func dateChanged() {
        print("Selected date: \(datePicker.date)")
    }
    
    @objc private func imageContainerTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true)
    }
    
    // MARK: - UIImagePickerController Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            memoryImageView.image = editedImage
            showSelectedImage()
        } else if let originalImage = info[.originalImage] as? UIImage {
            memoryImageView.image = originalImage
            showSelectedImage()
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func showSelectedImage() {
        cameraIconView.isHidden = true
        placeholderLabel.isHidden = true
        memoryImageView.isHidden = false
        
        guard let image = memoryImageView.image else { return }
        let imageAspectRatio = image.size.height / image.size.width
        let containerWidth = view.frame.width - 32
        let newHeight = containerWidth * imageAspectRatio
        
        let clampedHeight = min(newHeight, 600)
        
        imageContainerHeightConstraint?.update(offset: clampedHeight)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
