# My-Workout
## Launch the app
Open "My Workout.xcodeproj" using XCode. Then use Command+R to run the project. Alternately, you can use Command+U to run the tests.

## Architecture
I used MVVM in this project because the model provided from the wger API is slightly different from the model we want to display on the screen.
It allows me to isolate the code that maps the model to the viewModel.

Side note: I usually use a mix of MVC and MVVM in my projects, as they fit great together. MVC is the recommended architecture from apple and is straightforward. MVVM can be useful when the model or part of the model are different from what we want to display.

## Data structures
Struct are faster than classes as they are stocked in memory on the stack meanwhile classes are stocked on the heap. Moreover Apple advise developers to use struct as default. Therefore, I used struct for most of my data structures. The exceptions are:
- Subclasses of UIKit objects like ExerciseCell, AppDelegate or the view controllers.
- The FetchExerciseViewModelManager, it contains all the data related to exercises that we fetch. We want it to be a reference type and use it in any viewController.
- ExerciseService, it keeps track of the nextExercisesUrl variable and we want it updated for everyone that old a reference to the instance when we get exercises.

## Forced unwrapping!
I use forced unwrapping only in 3 cases:
- Outlets that must have a value.
- ViewController required properties. Working with storyboard means not being in charge of the instantiation of the view controllers, so we cannot implement a custom initializer that accepts values for every stored property. For example in this project, the detail view controller is useless if it doesn’t have a valid exerciseViewModel to work with. In other words, the exerciseViewModel property of the detail view controller should always have a value.
- If the application needs to access a resource from its bundle. An example in this project is the UIImage extension where we access the UIImage named "exercise-placeholder". The resource should be present in the application bundle. If it isn’t, then that means I have bigger problems to worry about.

## Leads for improvment:
- Higher test coverage.
- Load the exerciseTableView first without the images and then download the images, so that the tableView appears quickly.
- Load the images one at a time.
- Use a collectionView to display the images in the DetailExerciseViewController.
