//
//  ConfirmationViewController.swift
//  Trendeye
//
//  Created by Arnaldo Rozon on 4/9/21.
//

import UIKit

final class ConfirmationViewController: UIViewController {
    
    var selectedPhoto: UIImage!
    var controlsView = ConfirmationControlsView()
    
    var headerView: UIView = {
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = K.Colors.NavigationBar
        return header
    }()
    
    var headerLabel: UILabel = {
        let label = UILabel()
        let text = "Confirm Photo"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }()
    
    var photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        applyStyles()
        applyConfigurations()
        applyLayouts()
    }
    
    fileprivate func applyStyles() {
        let headerFontSize: CGFloat = 17
        view.backgroundColor = K.Colors.ViewBackground
        headerView.backgroundColor = K.Colors.ViewBackground
        headerLabel.font = AppFonts.Satoshi.font(face: .black, size: headerFontSize)
        headerLabel.textAlignment = .center
    }
    
    // MARK: - Configurations
    
    fileprivate func applyConfigurations() {
        configureNavigation()
        configurePhotoView()
    }
    
    fileprivate func configureNavigation() {
        navigationItem.hidesBackButton = true
    }
    
    fileprivate func configurePhotoView() {
        photoView.image = selectedPhoto
        photoView.contentMode = .scaleAspectFit
        photoView.backgroundColor = .systemTeal
        photoView.clipsToBounds = true
    }
    
}

// MARK: - Layout

fileprivate extension ConfirmationViewController {
    
    func applyLayouts() {
        layoutHeaderView()
        layoutPhotoView()
        layoutControlsView()
    }
    
    func layoutHeaderView() {
        let headerHeight: CGFloat = 100
        headerView.addSubview(headerLabel)
        headerLabel.fillOther(view: headerView)
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func layoutPhotoView() {
        let photoHeight: CGFloat = 545
        view.addSubview(photoView)
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            photoView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func layoutControlsView() {
        let controlsPadding: CGFloat = -30
        view.addSubview(controlsView)
        NSLayoutConstraint.activate([
            controlsView.topAnchor.constraint(equalTo: photoView.bottomAnchor),
            controlsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            controlsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: controlsPadding)
        ])
    }
    
}
