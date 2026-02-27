# 🍯 Memory Jar

<p align="center">
  <img src="screenshots/b1.png" width="30%" />
  <img src="screenshots/b2.png" width="30%" />
  <img src="screenshots/b3.png" width="30%" />
</p>

**Memory Jar** is a minimalist iOS application built with a modern **MVVM architecture**, designed to help you capture and cherish your most precious moments. Instead of scrolling through an endless feed, Memory Jar encourages a mindful approach: put your memories in the jar, and pull one out randomly whenever you need a boost of joy.

## ✨ Features

- **Modern MVVM Architecture**: The entire app is built using the Model-View-ViewModel pattern for clean, maintainable, and testable code.
- **Minimalist Honey Theme**: A clean, warm UI featuring glassmorphism and soft shadows.
- **Easy Capture**: Quickly add new memories with photos, text, and dates.
- **The Jar Logic**: No lists, no searching. Just press a button to pull a random memory from your jar.
- **Interactive Timeline**: A specialized `Memories` tab featuring a `UICalendarView`. Select any date to filter and view memories from that specific day.
- **Data Management**: Full control over your data with the ability to clear your jar directly from the settings.
- **Privacy First**: All your memories are stored locally on your device using Core Data.

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/tunaarikaya/MemoryJar.git
   ```
2. Open `Memory Jar.xcodeproj` in Xcode.
3. Build and run on your simulator or physical device!

## 🛠 Tech Stack

- **Architecture**: MVVM (Model-View-ViewModel)
- **UI Framework**: UIKit
- **Layout Management**: SnapKit
- **Data Persistence**: Core Data
- **Language**: Swift

## 📖 Project Structure

The project has been carefully organized to reflect the MVVM pattern:

- **Controllers (`View`)**: `HomeViewController`, `AddMemoryViewController`, `MemoriesViewController`, `SettingsViewController`, `MemoryDetailViewController`.
- **ViewModels (`ViewModel`)**: `HomeViewModel`, `AddMemoryViewModel`, `MemoriesViewModel`, `SettingsViewModel`.
- **Managers (`Model/Service`)**: `CoreDataManager` acting as the single source of truth for all local database operations.

---

<p align="center">
Developed with ❤️ by <a href="https://github.com/tunaarikaya">Tuna Arıkaya</a>
</p>
