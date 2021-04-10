//
//  CameraControlsView.swift
//  Trendeye
//
//  Created by Arnaldo Rozon on 4/8/21.
//

import UIKit
import AVKit

class CameraControlsView: UIView {
    
    var shootButton: CameraButton!
    var flipButton: CameraButton!
    var flashButton: CameraButton!
    
    var primaryButtonsContainer: UIStackView = {
        /**
         Contains the "Shoot" button
         */
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .equalCentering
        return stack
    }()
    
    var secondaryButtonsContainer: UIStackView = {
        /**
         Contains the "Flip" and "Flash" buttons
         */
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 1
        stack.distribution = .equalCentering
        return stack
    }()
    
    var previewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var galleryThumbnail: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor
        return view
    }()
    
    fileprivate func applyConfigurations() {
        configureButtons()
        configureThumbnail()
    }
    
    fileprivate func configureButtons() {
        // TODO: Refactor
        
        let shootButtonIcon = UIImage(systemName: "camera.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))
        let flipButtonIcon = UIImage(systemName: "arrow.triangle.2.circlepath", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium))
        let flashButtonIcon = UIImage(systemName: "bolt.slash.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium))
        
        shootButton = CameraButton(type: .system)
        shootButton.setTitle("Shoot", for: .application)
        shootButton.setTitleColor(.white, for: .normal)
        shootButton.backgroundColor = .black
        shootButton.setImage(shootButtonIcon, for: .normal)
        shootButton.tintColor = .white
        
        flipButton = CameraButton(type: .system)
        flipButton.setTitle("Flip", for: .application)
        flipButton.setTitleColor(.white, for: .normal)
        flipButton.backgroundColor = .black
        flipButton.setImage(flipButtonIcon, for: .normal)
        flipButton.tintColor = .white
        
        flashButton = CameraButton(type: .system)
        flashButton.setTitle("Flash", for: .application)
        flashButton.setTitleColor(.white, for: .normal)
        flashButton.backgroundColor = .black
        flashButton.setImage(flashButtonIcon, for: .normal)
        flashButton.tintColor = .white
    }
    
    fileprivate func configureThumbnail() {
        galleryThumbnail.layer.cornerRadius = 24
        galleryThumbnail.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        applyConfigurations()
        applyLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout

fileprivate extension CameraControlsView {
    
    // TODO: These constraints are a mess, but they work for now
    
    func applyLayouts() {
        layoutContainers()
        layoutThumbnail()
        layoutButtons()
    }
    
    func layoutContainers() {
        let screenWidth = UIScreen.main.bounds.width
        let halfScreenWidth = (screenWidth / 2)
        
        addSubview(previewContainer)
        addSubview(primaryButtonsContainer)
        
        NSLayoutConstraint.activate([
            previewContainer.topAnchor.constraint(equalTo: self.topAnchor),
            previewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            previewContainer.widthAnchor.constraint(equalToConstant: halfScreenWidth),
            previewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            primaryButtonsContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            primaryButtonsContainer.leadingAnchor.constraint(equalTo: previewContainer.trailingAnchor),
            primaryButtonsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
    func layoutThumbnail() {
        previewContainer.addSubview(galleryThumbnail)
        NSLayoutConstraint.activate([
            galleryThumbnail.centerYAnchor.constraint(equalTo: previewContainer.centerYAnchor),
            galleryThumbnail.leadingAnchor.constraint(equalTo: previewContainer.leadingAnchor, constant: 20),
            galleryThumbnail.heightAnchor.constraint(equalToConstant: 100),
            galleryThumbnail.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func layoutButtons() {
        secondaryButtonsContainer.addArrangedSubview(flipButton)
        secondaryButtonsContainer.addArrangedSubview(flashButton)
        primaryButtonsContainer.addArrangedSubview(shootButton)
        primaryButtonsContainer.addArrangedSubview(secondaryButtonsContainer)
        
        NSLayoutConstraint.activate([
            shootButton.heightAnchor.constraint(equalToConstant: 100),
            shootButton.widthAnchor.constraint(equalToConstant: 100),
            flipButton.heightAnchor.constraint(equalToConstant: 50),
            flipButton.widthAnchor.constraint(equalToConstant: 50),
            flashButton.heightAnchor.constraint(equalToConstant: 50),
            flashButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}