# Qt Weather Dashboard

A small desktop weather dashboard built with Qt 6: a QML interface on top of a C++ model that fetches live conditions from the [OpenWeatherMap](https://openweathermap.org/api) API. It shows the current temperature, a short description and an icon for one city, refreshes every five minutes, and has a day/night theme that is remembered between runs.

It is a working base for a larger dashboard, and the plan for getting there is in [ROADMAP.md](ROADMAP.md).

## Built with

- Qt 6 (Core, Quick), QML for the interface
- C++17 with CMake
- OpenWeatherMap "current weather" API

## Run it

You need Qt 6, CMake 3.16+ and a C++17 compiler, plus a free API key from OpenWeatherMap.

```bash
cmake -S . -B build
cmake --build build
OPENWEATHER_API_KEY=your_key_here ./build/WeatherDashboard
```

On Windows PowerShell: `$env:OPENWEATHER_API_KEY = "your_key_here"` before running.

| Variable | Required | Default | Purpose |
|---|---|---|---|
| `OPENWEATHER_API_KEY` | yes | none | Your OpenWeatherMap key. Without it the app shows "Set OPENWEATHER_API_KEY" |
| `OPENWEATHER_CITY` | no | `Helsinki,FI` | City to show, as OpenWeatherMap names it (`City,CountryCode`) |

The key is read from the environment and never stored in the code or the repository.

## Known limitations

These are tracked in the roadmap rather than hidden:

- The interface is loaded from the source directory's path, so a built copy only runs on the machine that built it.
- A failed request shows only a generic "Error loading weather", not the cause or the age of the data on screen.
- The city can only be changed through an environment variable.
- Continuous integration only checks that files exist; it does not compile the project.

## Project layout

```
src/main.cpp              entry point
src/backend/WeatherModel  fetches and exposes the weather to QML
src/qml/                  the interface
```

## Licence

Released under the [MIT License](LICENSE).
