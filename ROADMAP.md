# Roadmap

Where this project is going, in the order I plan to do it. Estimates are rough working hours and include tests and documentation. The first milestone fixes what is wrong today; later ones add what a real dashboard needs.

Legend: `[x]` done, `[ ]` planned.

## v0.2 — Make it correct and portable (about 12 h)

- [x] Read the API key from the environment instead of the source code.
- [x] Make the interface read from the C++ model. It used to run its own copy of the request in `main.qml`, which also fetched only once at startup and never refreshed.
- [x] Handle an empty `weather` array and a failed request in the response handler.
- [x] Fix garbled characters (the degree sign and the placeholder text) by saving the sources as UTF-8.
- [ ] **Load the interface from Qt resources.** `main.cpp` builds the QML path from `__FILE__`, so a copy built on one machine cannot find its interface on another. Use `qt_add_qml_module` and a `qrc:` URL. (3 h)
- [ ] **Remove dead code.** `Backend` is not in the build and duplicates the dark-mode logic in `WeatherModel`; `ChartCard.qml` is unused and reads a model that does not exist; `WeatherDashboard.qml` is empty. `WeatherModel` also carries its own `darkMode` while the QML works out day or night itself. Keep one settings object. (2 h)
- [ ] **Say why it failed.** A bad key, a rate limit and no network all show the same "Error loading weather". Report the cause, show the time of the last successful update, and mark old data as stale. (3 h)
- [ ] Add a request timeout and exponential backoff between retries. (2 h)
- [ ] Replace the hand-built request URL with proper query handling for every parameter. (1 h)
- [ ] Add `clang-format` and `qmllint` configuration and fix what they report. (1 h)

## v0.3 — Real continuous integration (about 8 h)

- [ ] Replace the file-existence checks with a workflow that builds on Ubuntu, Windows and macOS using `install-qt-action`. (4 h)
- [ ] Run the unit tests (v0.4) in the same workflow and fail the build on warnings. (2 h)
- [ ] Cache the Qt install and the CMake build directory so runs stay fast. (1 h)
- [ ] Add a build badge and a screenshot to the README. (1 h)

## v0.4 — Tests (about 10 h)

- [ ] Introduce Qt Test and a `tests/` target wired into CTest. (2 h)
- [ ] Parse the weather response in its own function so it can be tested without the network. Cover a normal response, a missing field, an empty `weather` array (the current code reads `.first()` on it unchecked) and malformed JSON. (4 h)
- [ ] Test `WeatherModel` against a fake network layer: success, timeout, 401, 404, 429. (3 h)
- [ ] Add a QML test for the day and night themes. (1 h)

## v0.5 — Settings and several cities (about 14 h)

- [ ] A settings screen: city, units (metric or imperial), refresh interval, theme. Persist with `QSettings`. (4 h)
- [ ] Let the user enter the API key in the app and store it in the operating system's credential store (via QtKeychain) rather than a plain settings file. (3 h)
- [ ] City search with suggestions from OpenWeatherMap's geocoding API. (3 h)
- [ ] Track several cities at once, shown as cards, with the list saved between runs. (4 h)

## v0.6 — A dashboard, not just a reading (about 14 h)

- [ ] Five-day forecast from the forecast endpoint, as a list model. (4 h)
- [ ] Draw the next 24 hours of temperature as a chart. This replaces the abandoned `ChartCard`. (4 h)
- [ ] Extra conditions: feels-like, humidity, wind, pressure, sunrise and sunset. (2 h)
- [ ] Cache the last response on disk and show it immediately on launch, before the network answers. (2 h)
- [ ] Download weather icons once and keep them locally instead of fetching them on every refresh. (2 h)

## v0.7 — Shipping it (about 8 h)

- [ ] Windows installer through `windeployqt`, a macOS app bundle through `macdeployqt` and a Linux AppImage. (5 h)
- [ ] Publish versioned builds as GitHub Releases from a tagged workflow. (2 h)
- [ ] Keep a `CHANGELOG.md` and follow semantic versioning. (1 h)

## Later

- A second data provider with no API key (for example Open-Meteo or the Finnish Meteorological Institute's open data) behind a common interface, so the app works without signing up for anything.
- Finnish and English interface text through Qt's translation tools.
- Keyboard navigation and screen-reader labels throughout.
- Severe-weather alerts as desktop notifications.
- A compact always-on-top mode.

## Principles

- The app must keep working when the network does not: stale data is shown as stale, never as current.
- No secrets in the repository, ever. Configuration comes from the environment or the operating system's credential store.
- Every behaviour fix ships with a test that fails without it.
