# Amplify Flutter Storage Gallery App

[![HitCount](https://hits.dwyl.com/offlineprogrammer/amplify_storage_app.svg?style=flat-square&show=unique)](http://hits.dwyl.com/offlineprogrammer/amplify_storage_app)

This is a sample app that uses [`Amplify Storage`](https://docs.amplify.aws/lib/storage/getting-started/q/platform/flutter/) to upload images to AWS S3


## Previews

<p align="center">
  <img  src="https://user-images.githubusercontent.com/12375969/185515984-387669a6-3644-4842-8627-4f1a9133dede.gif" />
</p>


## Getting Started
* [`Install`](https://docs.amplify.aws/cli/start/install/) and configure Amplify CLI
* A Flutter application targeting Flutter SDK >= 2.10.0 (stable version).
* An iOS configuration targeting at least iOS 11.0
* An Android configuration targeting at least Android API level 21 (Android 5.0) or above


## Running the App
- Clone the application.

```bash
git clone https://github.com/offlineprogrammer/amplify_storage_app
```

- Create your amplify environment for this app

```bash
amplify init
```

- Install dependencies

```bash
flutter pub get
```

- Build all your local backend resources and provision it in the cloud.

```bash
amplify push
```

- Run the app and try uploading images.


## App Architecture and Folder Structure

The code of the app implements clean architecture to separate the app layers with a feature-first approach for folder structure. I used [`Riverpod`](https://riverpod.dev/) for state management and [`Freezed`](https://pub.dev/packages/freezed) for the storage file model


#### Folder Structure

```
lib
├── features
│   ├── storage_file
│   │   ├── controller
│   │   ├── models
│   │   ├── services
│   │   └── ui
│   │       └── storage_file_list
├── main.dart
├── storage_gallery_app.dart
└── utils.dart
```

* `main.dart` file has Amplify initialization & configuration code and wraps the root `StorageGalleryApp` with a `ProviderScope`
* `storage_gallery_app.dart` has the root `MaterialApp` wrapped in the Amplify Authenticator to add complete authentication flows to the App.
* The `features/storage_file` folder contains code for displaying/uploading storage file
    * `ui/storage_file_list` contain the implementation to display the storage files gallery & the storage upload indicator
    * `services` is the app services layer
        *  `storage_service.dart` is the service & provider to use Amplify Storage for files listing & uploading
     * `models` is the storage_file model generated using Freezed
     * `controller` is an abstract layer that used by the ui for the buisness logic
