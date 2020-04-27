# My-Workout
## Launch the app
To launch the app, open "My Workout.xcodeproj" using XCode and press Command+R.

## Architecture
I used MVVM in this project because the model provided from the wger API is slightly different from the model we want to display on the screen.
It allows me to isolate the code that maps the model to the viewModel.

Side note: I usually use a mix of MVC and MVVM in my projects, as they fit great together. MVC is the recommended architecture from apple and is straightforward. MVVM can be useful when the model or part of the model are different from what we want to display.

## Data structures
Struct are faster than classes as they are stocked in memory on the stack meanwhile classes are stocked on the heap. Moreover Apple advise developers to use struct as default. Therefore, I used struct for most of my data structures. The exceptions are:
- Subclasses of UIKit objects like ExerciseCell, AppDelegate or the view controllers.
- The FetchExerciseViewModelManager, it contains all the data related to exercises that we fetch. We want it to be a reference type and use it in any viewController.
- ExerciseService, it keeps track of the nextExercisesUrl variable and we want it updated for everyone that old a reference to the instance when we get exercises.

## Leads for improvment:
- Load the exerciseTableView first without the images and then download the images, so that the tableView appears quickly.
- Load the images one at a time using a delegate, notifications or reactive programming.
- Use a collectionView to display images in the DetailExerciseViewController.
