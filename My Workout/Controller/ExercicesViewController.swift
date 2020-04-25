//
//  ViewController.swift
//  My Workout
//
//  Created by Arthur Duver on 23/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    @IBOutlet private weak var exerciseTableView: UITableView!
    private var exercises: Set<ExerciseViewModel>?
    private var dataSource: UITableViewDiffableDataSource<Section, ExerciseViewModel>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.global(qos: .userInitiated).async {
            let fetchHandler = FetchExerciseManager()
            fetchHandler.loadData() { (exercisesViewModel) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.configureDataSource(display: exercisesViewModel)
                }
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - DataSource
    func configureDataSource(display exercises: Set<ExerciseViewModel>) {
        dataSource = UITableViewDiffableDataSource<Section, ExerciseViewModel>(tableView: exerciseTableView) {
            [unowned self] (tableView, indexPath, exerciseViewModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
            if let cell = cell as? ExerciseCell {
                self.configureExerciseCell(cell: cell, exercise: exerciseViewModel)
            }
            return cell
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, ExerciseViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(exercises))
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func addPageToExerciseTableView() {
        
    }
    
    func configureExerciseCell(cell: ExerciseCell, exercise: ExerciseViewModel) {
        cell.categoryLabel.text = exercise.category
        cell.nameLabel.text = exercise.name
        cell.equiplentLabel.text = exercise.equipment
        cell.primaryMusclesLabel.text = exercise.primaryMuscles
        cell.secondaryMusclesLabel.text = exercise.secondaryMuscles
    }
    
    //MARK: -  Delegate
    
}
