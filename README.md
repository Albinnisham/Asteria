# Asteria 🌌

**Your date. Your universe.**

Asteria is a beginner-friendly Flutter application that allows users to choose a meaningful date and discover NASA’s Astronomy Picture of the Day from that day.

This project was created for the **Tuwaiq Flutter Bootcamp** using Flutter and the official NASA APOD API.

## Features

- Space-themed welcome screen
- Meet the Builder page
- Custom date-selection interface
- Flutter calendar picker
- Birthday, Today, and Random Date shortcuts
- NASA APOD results for a selected date
- Astronomy image, title, date, and explanation
- Full APOD details page
- Support for image and video APOD results
- HD image option when available
- Loading and error states
- Option to explore another date
- Responsive layout for Android and iOS

## Screenshots

### Main Screens

| Welcome | Meet the Builder | Date Selection |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/20b34135-55fe-45b8-b699-4e2776c83633" alt="Asteria welcome screen" width="250"> | <img src="https://github.com/user-attachments/assets/7af17bfc-6238-4648-8adf-ef77eb72a5d8" alt="Meet the Builder screen" width="250"> | <img src="https://github.com/user-attachments/assets/1c67e33b-cc53-43e4-b4e8-7ea7b94c79a6" alt="Date-selection screen" width="250"> |

### NASA Discovery

| Cosmic Moment | APOD Details | HD Image |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/0d35ac4d-17ae-4777-972c-4c0d588d1674" alt="Cosmic Moment screen" width="250"> | <img src="https://github.com/user-attachments/assets/286e9fc3-dfb5-4fd5-9215-0890f5484f9f" alt="APOD details screen" width="250"> | <img src="https://github.com/user-attachments/assets/f211ab30-c7f9-4381-a527-ccfd860cc256" alt="HD image screen" width="250"> |

## Demo

Watch the screen recording below to see Asteria in action.

https://github.com/user-attachments/assets/fb74467b-390d-43b0-a295-d133903dbb61

## How It Works

1. The user opens Asteria.
2. The user selects **Explore a Date** or **Meet the Builder**.
3. The user chooses a meaningful date.
4. Asteria formats the selected date as `YYYY-MM-DD`.
5. The selected date is sent to the NASA API.
6. NASA returns astronomy information for that date.
7. The user can select a cosmic moment and read its full story.
8. The user can view the HD image when one is available.

For example, if the user chooses August 2, 2006, the API receives:

```text
2006-08-02
```

## NASA API

Asteria uses NASA’s Astronomy Picture of the Day API:

```text
https://api.nasa.gov/planetary/apod
```

Example request:

```text
https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2006-08-02
```

NASA APOD entries are available from June 16, 1995.

## Built With

- Flutter
- Dart
- Material Design
- NASA Astronomy Picture of the Day API
- `http` package
- `intl` package

## Widgets Used

Some of the main Flutter widgets used in Asteria include:

- `Scaffold` and `SafeArea`
- `Column`, `Row`, and `Stack`
- `ListView` and `FutureBuilder`
- `Image.network`
- `FilledButton` and `IconButton`
- `showDatePicker`
- `CircularProgressIndicator`
- Custom reusable widgets

## Project Structure

```text
lib/
├── main.dart
├── models/
│   ├── apod_list_item.dart
│   └── apod_model.dart
├── services/
│   └── api.dart
├── screens/
│   ├── splash_screen.dart
│   ├── builder_screen.dart
│   ├── date_selection_screen.dart
│   ├── home_screen.dart
│   └── details_screen.dart
└── widgets/
    ├── cosmic_background.dart
    ├── apod_card.dart
    ├── date_selector.dart
    └── primary_button.dart
```

## API Key

The project uses NASA’s development key:

```dart
const String apiKey = 'DEMO_KEY';
```

`DEMO_KEY` has a limited request allowance. A free NASA API key can be created at:

https://api.nasa.gov/

The new key can then replace `DEMO_KEY` inside the API service.

## Error Handling

Asteria handles:

- Internet connection problems
- NASA API errors
- Request timeouts
- Empty API results
- Missing or unavailable images
- Video APOD results
- Invalid or unsupported dates

## Builder

**Sham Albinni**  
Computer Science Student at IMSIU

Asteria was built with curiosity, code, love, and a little help from the universe.

## NASA Attribution

Astronomy images, titles, dates, and explanations are provided by NASA’s Astronomy Picture of the Day service.

This project is not officially affiliated with or endorsed by NASA.

## License

This project was created for educational purposes as part of the **Tuwaiq Flutter Bootcamp**.
