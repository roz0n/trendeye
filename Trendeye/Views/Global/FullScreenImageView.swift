//
//  FullscreenImageView.swift
//  Trendeye
//
//  Created by Arnaldo Rozon on 4/21/21.
//

import UIKit

// TODO: Add an error view incase there's a failure getting the large image
// TODO: Add an error view incase access to photos is restricted and the file could not be saved
class FullScreenImageView: UIViewController, UIGestureRecognizerDelegate {
  
  var closeButton = UIButton(type: .system)
  var saveButton = UIButton(type: .system)
  var isZooming = false
  var originalImageCenter: CGPoint?
  
  var url: String! {
    didSet {
      self.url = url.replacingOccurrences(of: "small", with: "big")
      CacheManager.shared.fetchAndCacheImage(from: self.url)
      imageView.image = CacheManager.shared.imageCache.object(forKey: self.url! as NSString)
    }
  }
  
  var image: UIImage? {
    didSet {
      imageView.image = image
    }
  }
  
  let backgroundBlurView: UIVisualEffectView = {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let headerBlurView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = K.Colors.NavigationBar
    return view
  }()
  
  let headerControls: UIStackView = {
    let view = UIStackView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.distribution = .equalSpacing
    view.axis = .horizontal
    return view
  }()
  
  let imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    view.clipsToBounds = false
    view.isUserInteractionEnabled = true
    return view
  }()
  
  override func viewDidLoad() {
    applyConfigurations()
    applyLayouts()
  }
  
  // MARK: - Configurations
  
  fileprivate func applyConfigurations() {
    configureHeaderControls()
    configureGestures()
  }
  
  fileprivate func configureHeaderControls() {
    let closeImage = UIImage(systemName: K.Icons.Close)
    let saveImage = UIImage(systemName: K.Icons.Save)
    
    closeButton.addTarget(self, action: #selector(handleCloseTap), for: .touchUpInside)
    closeButton.setImage(closeImage, for: .normal)
    closeButton.tintColor = K.Colors.White
    
    saveButton.addTarget(self, action: #selector(handleSaveTap), for: .touchUpInside)
    saveButton.setImage(saveImage, for: .normal)
    saveButton.tintColor = K.Colors.White
  }
  
  fileprivate func configureGestures() {
    let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(sender:)))
    pinch.cancelsTouchesInView = false
    pinch.delegate = self
    imageView.addGestureRecognizer(pinch)
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
    pan.cancelsTouchesInView = false
    pan.delegate = self
    imageView.addGestureRecognizer(pan)
  }
  
  // MARK: - UIGestureRecognizerDelegate
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  // MARK: - Gestures
  
  @objc func handleCloseTap() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func handleSaveTap() {
    guard let image = self.imageView.image else { return }
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    presentSimpleAlert(title: "Saved Successfully",
                       message: "This image has been saved to your camera roll.",
                       actionTitle: "Close")
  }
  
  @objc func handlePinchGesture(sender: UIPinchGestureRecognizer) {
    guard sender.view != nil else { return }
    
    switch sender.state {
      case .began:
        if sender.scale > 1 {
          isZooming = true
        }
      case .changed:
        guard sender.scale > 0.90 else {
          UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            self?.imageView.transform = .identity
          }
          return
        }
        
        let pinchCenter = CGPoint(x: sender.location(in: sender.view).x - imageView.bounds.midX,
                                  y: sender.location(in: sender.view).y - imageView.bounds.midY)
        imageView.transform = CGAffineTransform(translationX: pinchCenter.x, y: pinchCenter.y)
          .scaledBy(x: sender.scale, y: sender.scale)
          .translatedBy(x: -(pinchCenter.x), y: -(pinchCenter.y))
      case .ended:
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
          guard let center = self?.originalImageCenter else { return }
          self?.imageView.center = center
          self?.imageView.transform = .identity
        } completion: { (_) in
          self.isZooming = false
        }
      default:
        return
    }
  }
  
  @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
    guard self.isZooming else { return }
    
    switch sender.state {
      case .began:
        self.originalImageCenter = sender.view?.center
      case .changed:
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
          view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
          sender.setTranslation(CGPoint.zero, in: imageView.superview)
        }
      default:
        return
    }
  }
  
}

// MARK: - Layout

fileprivate extension FullScreenImageView {
  
  func applyLayouts() {
    layoutBackgroundBlurView()
    layoutHeaderBlurView()
    layoutHeaderControls()
    layoutImageView()
  }
  
  func layoutBackgroundBlurView() {
    view.addSubview(backgroundBlurView)
    NSLayoutConstraint.activate([
      backgroundBlurView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      backgroundBlurView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      backgroundBlurView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      backgroundBlurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  func layoutHeaderBlurView() {
    let headerHeight: CGFloat = 72
    view.addSubview(headerBlurView)
    NSLayoutConstraint.activate([
      headerBlurView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerBlurView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      headerBlurView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      headerBlurView.heightAnchor.constraint(equalToConstant: headerHeight)
    ])
  }
  
  func layoutHeaderControls() {
    let padding: CGFloat = 20
    headerBlurView.addSubview(headerControls)
    headerControls.addArrangedSubview(closeButton)
    headerControls.addArrangedSubview(saveButton)
    NSLayoutConstraint.activate([
      headerControls.topAnchor.constraint(equalTo: headerBlurView.topAnchor),
      headerControls.leadingAnchor.constraint(equalTo: headerBlurView.leadingAnchor, constant: padding),
      headerControls.trailingAnchor.constraint(equalTo: headerBlurView.trailingAnchor, constant: -(padding)),
      headerControls.bottomAnchor.constraint(equalTo: headerBlurView.bottomAnchor)
    ])
  }
  
  func layoutImageView() {
    let padding: CGFloat = 20
    view.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: headerBlurView.safeAreaLayoutGuide.bottomAnchor, constant: padding),
      imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
      imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(padding)),
      imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(padding))
    ])
  }
  
}
