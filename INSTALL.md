
# Puzzle & Grow Installation Guide

This guide will walk you through the process of compiling, installing, and running the "Puzzle & Grow" game on your iPhone using Xcode.

## Prerequisites

Before you begin, make sure you have the following:

*   A Mac computer with the latest version of macOS.
*   The latest version of Xcode installed from the Mac App Store.
*   An Apple ID enrolled in the Apple Developer Program.
*   An iPhone to test the app on.

## Step 1: Cloning the Repository

First, you need to clone the GitHub repository to your Mac.

1.  Open the **Terminal** app on your Mac. You can find it in `Applications/Utilities`.
2.  Navigate to the directory where you want to store the project. For example, to save it to your Desktop, type:
    ```
    cd ~/Desktop
    ```
3.  Clone the repository using the following command:
    ```
    git clone https://github.com/samersh/Pgame.git
    ```

## Step 2: Opening the Project in Xcode

Now that you have the project on your Mac, you can open it in Xcode.

1.  Navigate to the directory where you cloned the repository.
2.  Find the file named `PuzzleAndGrow.xcodeproj` and double-click it to open the project in Xcode.

## Step 3: Configuring Code Signing

To run the app on your iPhone, you need to configure code signing with your Apple Developer account.

1.  In Xcode, select the `PuzzleAndGrow` project in the project navigator on the left.
2.  Select the `PuzzleAndGrow` target from the list.
3.  Go to the **Signing & Capabilities** tab.
4.  In the **Team** dropdown, select your Apple Developer account. If you haven't added your account to Xcode yet, you can do so by clicking "Add an Account" and signing in with your Apple ID.
5.  Make sure that **Automatically manage signing** is checked. Xcode will handle the creation of the necessary provisioning profiles and certificates.

## Step 4: Building and Running on an iPhone

You're now ready to build and run the game on your iPhone.

1.  Connect your iPhone to your Mac using a USB cable.
2.  If this is the first time you've connected your iPhone to your Mac for development, you may see a "Trust This Computer" alert on your iPhone. Tap **Trust**.
3.  You may also need to enable **Developer Mode** on your iPhone. Go to **Settings > Privacy & Security > Developer Mode** and toggle it on.
4.  In Xcode, at the top of the window, you will see a device selector. Click on it and select your iPhone from the list.
5.  Click the **Run** button (the play icon) in the top-left corner of the Xcode window.

Xcode will now build the project and install it on your iPhone. Once the process is complete, the "Puzzle & Grow" game will launch automatically on your device.

## Troubleshooting

*   **"Could not launch" error:** If you see an error message that says "Could not launch 'PuzzleAndGrow'", make sure your iPhone is unlocked and that you have trusted the computer.
*   **"Untrusted Developer" alert:** If you see an "Untrusted Developer" alert when you try to open the app on your iPhone, you need to trust the developer certificate. Go to **Settings > General > VPN & Device Management**, tap on your developer app certificate, and then tap **Trust**.

Enjoy your game!
