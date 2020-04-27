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
    private var dataSource: UITableViewDiffableDataSource<Section, ExerciseViewModel>?
    private let fetchExerciseViewModelManager = FetchExerciseViewModelManager()
    private var loading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            self.fetchExerciseViewModelManager.loadData() { (exercisesViewModel) in
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
        if let indexPath = exerciseTableView.indexPathForSelectedRow,
            let exerciseViewModel = dataSource?.itemIdentifier(for: indexPath),
            let detailViewController = segue.destination as? DetailExerciseViewController
        {
            detailViewController.exerciseViewModel = exerciseViewModel
            exerciseTableView.deselectRow(at: indexPath, animated: true)
        }
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
    
    func configureExerciseCell(cell: ExerciseCell, exercise: ExerciseViewModel) {
        cell.categoryLabel.text = exercise.category
        cell.nameLabel.text = exercise.name
        cell.equipmentLabel.text = exercise.equipment
        cell.primaryMusclesLabel.text = exercise.primaryMuscles
        cell.secondaryMusclesLabel.text = exercise.secondaryMuscles
        if let image = exercise.image {
            cell.exerciseImage.backgroundColor = .white //Fix the translucent images in dark mode
            cell.exerciseImage.image = image
        } else {
            cell.exerciseImage.backgroundColor = .systemBackground
            cell.exerciseImage.image = UIImage.Exercise.placeholder
        }
    }

    func addItemsToTableView(items: [ExerciseViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            if var currentSnapshot = self.dataSource?.snapshot() {
                currentSnapshot.appendItems(items)
                self.dataSource?.apply(currentSnapshot)
                self.loading = false
            }
        }
    }
}

//MARK: -  Delegate

extension ExercisesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == dataSource?.snapshot().numberOfItems(inSection: .main), !loading {
            loading = true
            addDataPageToTableView()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "exerciseDetails", sender: self)
    }
    
    private func addDataPageToTableView() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            self.fetchExerciseViewModelManager.loadData() { [weak self] (exercisesViewModel) in
                guard let self = self else {
                    return
                }
                self.addItemsToTableView(items: Array(exercisesViewModel))
            }
        }
    }
}
