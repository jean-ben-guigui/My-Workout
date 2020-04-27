//
//  DetailExerciseViewController.swift
//  My Workout
//
//  Created by Arthur Duver on 26/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import UIKit
import WebKit

class DetailExerciseViewController: UIViewController {
    
    var exerciseViewModel: ExerciseViewModel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var primaryMusclesLabel: UILabel!
    @IBOutlet weak var secondaryMusclesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseImage2: UIImageView!
    @IBOutlet weak var exerciseImage3: UIImageView!
    @IBOutlet weak var exerciseImage4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabels()
        clearImages()
        configureImages()
    }
    
    //MARK: - LABELS
    
    func configureLabels() {
        nameLabel.text = exerciseViewModel.name
        categoryLabel.text = exerciseViewModel.category
        equipmentLabel.text = exerciseViewModel.equipment
        
        if let description = exerciseViewModel.description {
            descriptionLabel.attributedText = description.htmlToAttributedString
        }
        primaryMusclesLabel.text = exerciseViewModel.primaryMuscles
        secondaryMusclesLabel.text = exerciseViewModel.secondaryMuscles
    }
    
    //MARK: - IMAGES
    
    func configureImages() {
        if exerciseViewModel.image != nil {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else {
                    return
                }
                let imageService = ExerciseImageService()
                imageService.getAllImages(for: self.exerciseViewModel) { [weak self] (imagesResult) in
                    switch imagesResult {
                    case .success(let images):
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else {
                                return
                            }
                            var fourImagesArray = [UIImage?]()
                            for index in 0...3 {
                                fourImagesArray.append(images.count > index ? images[index] : nil)
                            }
                            
                            self.setImage(fourImagesArray[0], in: self.exerciseImage)
                            self.setImage(fourImagesArray[1], in: self.exerciseImage2)
                            self.setImage(fourImagesArray[2], in: self.exerciseImage3)
                            self.setImage(fourImagesArray[3], in: self.exerciseImage4)
                                
                        }
                    case .failure(_):
                        return
                    }
                }
            }
        }
    }
    
    func clearImages() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.setImage(nil, in: self.exerciseImage)
            self.setImage(nil, in: self.exerciseImage2)
            self.setImage(nil, in: self.exerciseImage3)
            self.setImage(nil, in: self.exerciseImage4)
        }
    }
    
    func setImage(_ image: UIImage?, in view: UIImageView) {
        if let image = image {
            view.backgroundColor = .white //Fix the translucent images in dark mode
            view.image = image
        } else {
            view.backgroundColor = .systemBackground
            view.image = nil
        }
    }
}
