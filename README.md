# Ekyc

A Flutter package designed to automate the eKYC process. This app allows users to capture and submit essential documents and biometrics, including customer photos, National ID (NID) front and back images, and digital signatures. The captured images are processed locally on the device, and liveness checks for customer photos are handled in real-time.

## Application Features

- **Customer Photo Capture**: Take a selfie using the front camera.
- **NID Front and Back Capture**: Capture both sides of the National ID, with cropping features for better precision.
- **Signature Capture**: Capture the customer's signature.

## How It Works

The eKYC package operates through a streamlined workflow:

1. **Camera Utilization**: The app switches between the front and rear cameras depending on the document type. The front camera is used for customer photos (selfie), and the rear camera is used for capturing the NID (front and back) and signatures.
2. **Image Cropping**: For NID capture, the app automatically crops the images to enhance accuracy.
3. **Image Preview and Retake**: After capturing an image, the user can preview it and retake the photo if necessary.
4. **Image Processing**: Captured images are processed, and in some cases, cropped to a desired region (e.g., for NID).
5. **State Management**: The app uses the `ImageCaptureBloc` to manage the state of the captured images, ensuring a smooth user experience.

### App Flow

1. **Customer captures 4 images one by one** (Customer Photo, NID Front, NID Back, or Signature).
2. **The camera is opened** for the user to capture the images one by one.
3. **Captured images are previewed** and saved.
4. **Once all images are captured**, the user can proceed to the next step for submission.

## Build and Run Setup

### Prerequisites

To set up and run the project, ensure the following tools are installed:

1. **Homebrew (Linux/Mac OS)** or **Chocolatey (Windows)** for package management.
2. **Dart SDK**.
3. **Flutter Version Manager (fvm)**.

#### Setup for Linux/Mac OS Using Homebrew

```bash
# Install Dart SDK
brew install dart-sdk

# Install FVM (Flutter Version Manager)
brew tap leoafarias/fvm
brew install fvm

# Activate FVM
dart pub global activate fvm
```

### Run Instructions

#### Install the Flutter Version

```bash
fvm install
```

#### Generate Localization Files

```bash
fvm flutter gen-l10n
```

#### Get Dependencies

```bash
fvm flutter pub get
```

#### Generate Build Files and Clean Conflicts

```bash
fvm dart pub run build_runner build -d
```

#### Running the App in Debug Mode

You can run the app in debug mode using the following VSCode configuration:

1. Go to **Run and Debug** in VSCode.
2. Select **Ekyc (debug mode)** and press **Run**.

```bash
fvm flutter run -t example/lib/main.dart --debug
```

#### Running the App in Release Mode

To run the app in release mode, select **Ekyc (release mode)** in VSCode or use the following command:

```bash
fvm flutter run -t example/lib/main.dart --release
```

### VSCode Configuration

The app includes a pre-configured `launch.json` for VSCode to simplify the debugging and running process:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Ekyc (debug mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "program": "example/lib/main.dart"
        },
        {
            "name": "Ekyc (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "program": "example/lib/main.dart"
        }
    ]
}
```

This allows to easily switch between debug and release modes while running the app.
