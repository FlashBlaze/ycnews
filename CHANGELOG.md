# Changelog

## 1.0.2

### :sparkles: Features

- Added options to enable or disable WebView and Javascript in settings
- Visited links greyed out for that sessions
- Display app version

### :wrench: Code changes

- Using custom `WebView` instead of webview of `url_launhcer` to gain better control of the webview to add more options to it in future

## 1.0.1

### :sparkles: Features

- Added **temporary** comment web view
- Display upvotes count
- Bottom navbar and settings screen (more stuff will be added soon™) which currently contains an _About_ section

### :bug: Bug Fixes

- Fixed crash on ycombinator links
- Fixed ycombinator link rendering

### :wrench: Code changes

- Restructured the app by breaking `main.dart` into `home.dart`
- Created a separate folder for screens/UI widgets

## 1.0.0

- Able to fetch and view posts from the API
- View comment count on each post
