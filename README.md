# Flutter Post Viewer

A simple mobile application built with **Flutter** to display posts fetched from the [JSONPlaceholder API](https://jsonplaceholder.typicode.com/posts).

## Features

- Displays a list of posts with a light yellow background.
- Clicking a post marks it as read and changes the background to white.
- Each post has a timer icon that starts counting when the post appears and pauses when it's out of view.
- Clicking a post shows the full details on a new screen.
- Uses local storage to persist data and syncs with the API in the background.

## File Structure

- `post.dart`: Defines the post model.
- `post_repository.dart`: Handles fetching posts from the API.
- `local_storage_service.dart`: Manages local data storage.
- `post_bloc.dart`: Manages the app’s state using the BLoC pattern.
- `post_event.dart`: Defines events for post-related actions.
- `post_state.dart`: Defines states for post-related actions.
- `home_screen.dart`: The main screen showing the list of posts.
- `post_detail_screen.dart`: Displays details of a selected post.
- `error_widget.dart`: Displays error messages to the user.
- `post_tile.dart`: Represents each post item in the list.
- `main.dart`: The entry point of the app.

## Requirements

- **Flutter**: Latest version.
- **Dart**: Compatible version with Flutter.
- **Packages**:
    - `http`: For API requests.
    - `shared_preferences`: For local data storage.
    - `flutter_bloc`: For state management.

## Setup

1. Clone the repository:

```bash
git clone <repository_link>
cd <project_directory>
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## Application Flow

1. **Home Screen**:  
   Displays a list of posts. Each post has a random timer that starts when it’s visible. When a post is clicked, it’s marked as read and navigates to the detail screen.

2. **Post Detail Screen**:  
   Shows the full post description when clicked.

3. **Timer Functionality**:  
   Each post has a timer that pauses when it's out of view and resumes when it reappears.

4. **Local Storage**:  
   Displays posts from local storage and syncs with the API for updates.

## How to Run

1. Clone the repo.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the app.

---