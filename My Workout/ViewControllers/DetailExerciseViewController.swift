//
//  DetailExerciceViewController.swift
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        // Do any additional setup after loading the view.
    }
    

    func configureView() {
        nameLabel.text = exerciseViewModel.name
        categoryLabel.text = exerciseViewModel.category
        equipmentLabel.text = exerciseViewModel.equipment
        
        if let description = exerciseViewModel.description {
            descriptionLabel.attributedText = description.htmlToAttributedString
        }
        primaryMusclesLabel.text = exerciseViewModel.primaryMuscles
        secondaryMusclesLabel.text = exerciseViewModel.secondaryMuscles
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
