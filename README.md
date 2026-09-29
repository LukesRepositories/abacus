# Abacus

A Flutter mental-arithmetic trainer. Each round presents five randomly generated questions (multiplication, addition, subtraction and division, plus a fallback multiplication row). Answer them against the clock, and your results are saved locally so you can track your progress over time.

## Features

- **Arithmetic puzzle**: five questions per session. Each row turns green when your answer is right and red when it's wrong.
- **Timed sessions**: a stopwatch starts when the puzzle loads and stops when you submit the final answer.
- **Difficulty levels**: choose Easy, Medium or Hard, which changes the number ranges used for each operation.
- **Session history**: every completed session is logged with its score, difficulty and total time, and can be deleted from the Profile page.
- **Persistent settings**: your chosen difficulty is stored in the database and survives app restarts.
- **Clean maths**: division questions are adjusted so the answer is always a whole number, and subtraction never produces a negative result.

## How It Works

1. Open the **Puzzle** tab and type the answer to each question.
2. Press *Enter/Submit* on the keyboard to lock in an answer. Focus moves automatically to the next row.
3. After the fifth answer, the session is saved to the database and a confirmation dialogue appears.
4. Press **Reset** at any time to generate a fresh set of questions using your current difficulty.

### Difficulty Ranges

Each operand is a random integer between 1 and the value shown (inclusive).

| Operation      | Easy                | Medium              | Hard                 |
|----------------|---------------------|---------------------|----------------------|
| Multiplication | 10 x 10             | 30 x 19             | 90 x 90              |
| Addition       | 30 + 30             | 98 + 98             | 300 + 300            |
| Subtraction    | 30 - 30             | 98 - 98             | 800 - 600            |
| Division       | up to 50 ÷ up to 10 | up to 98 ÷ up to 11 | up to 180 ÷ up to 20 |

## Tech Stack

- [Flutter](https://flutter.dev/) / Dart
- [go_router](https://pub.dev/packages/go_router): declarative routing with a `StatefulShellRoute` for bottom navigation that preserves each tab's state
- [sqflite](https://pub.dev/packages/sqflite): local SQLite storage
- [path](https://pub.dev/packages/path): database file path handling

## Project Structure

```
lib/
├── model/
│   └── arithmetic_puzzle/
│       ├── maths_puzzle.dart       # MathsPuzzleObject (operands, operator, answer)
│       └── puzzle_session.dart     # PuzzleSession data model
├── pages/
│   ├── arithmetic_puzzle.dart      # Main puzzle screen
│   ├── settings.dart               # Difficulty selection
│   ├── profile.dart                # Session history
│   └── about.dart                  # About page
├── services/
│   ├── database_service.dart       # SQLite singleton (sessions + settings)
│   └── puzzle_generator.dart       # Question generation and difficulty ranges
├── widgets/
│   ├── alert_dialogues.dart        # Reusable dialogues
│   └── scaffold_with_nav_bar.dart  # Bottom navigation shell
└── navigation.dart                 # GoRouter configuration
```

## Navigation

| Route            | Screen                               |
|------------------|--------------------------------------|
| `/puzzle`        | Arithmetic puzzle (initial route)    |
| `/settings`      | Difficulty settings                  |
| `/profile`       | Session history                      |
| `/profile/about` | About page, pushed on top of Profile |

## Database Schema

The app uses a SQLite database (`puzzle_sessions.db`) with two tables.

**`puzzle_sessions`**

| Column        | Type                     | Description                    |
|---------------|--------------------------|--------------------------------|
| `id`          | INTEGER PK AUTOINCREMENT | Session ID                     |
| `dateTime`    | DATETIME                 | When the session was completed |
| `score`       | INTEGER                  | Number of correct answers      |
| `total`       | INTEGER                  | Number of questions            |
| `mode`        | TEXT                     | Difficulty used                |
| `totalTimeMs` | INTEGER                  | Total time in milliseconds     |

**`settings`**: a single-row table (enforced with `CHECK (id = 1)`)

| Column       | Type       | Description                                   |
|--------------|------------|-----------------------------------------------|
| `id`         | INTEGER PK | Always 1                                      |
| `difficulty` | TEXT       | `Easy`, `Medium` or `Hard` (default `Medium`) |

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- An emulator, simulator or physical device

### Installation

```bash
# Clone the repository
git clone https://github.com/<your-username>/abacus.git
cd abacus

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Possible Future Improvements

- Configurable number of questions per session
- Statistics and progress charts on the Profile page
- Formatting times as seconds/minutes rather than raw milliseconds
- Additional puzzle modes

## License

Add your preferred licence here (e.g. MIT).