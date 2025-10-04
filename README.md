## Clean Architecture Practice (Flutter)

A small, production-style Flutter app demonstrating Clean Architecture with a feature module for users. It fetches a user from `jsonplaceholder` via `dio`, manages state with `flutter_bloc`, handles connectivity, and shows offline/loading states using Lottie animations. Simple caching is provided with `shared_preferences`.

### Tech stack
- **Flutter** (stable channel) with **Dart ≥ 3.7.2**
- **dio**: HTTP client
- **flutter_bloc**: state management (Cubit)
- **dartz**: Either for error handling
- **shared_preferences**: lightweight local cache
- **data_connection_checker_tv**: connectivity stream/status
- **lottie**: animated loading/empty states

---

## What this app does
- Fetches a single user from `https://jsonplaceholder.typicode.com/users/{id}` on startup (default id is 1).
- Displays the user data in a simple UI with a custom app bar and widgets.
- Reacts to connectivity changes: shows a "No Internet Connection" Lottie when offline, loading animation while fetching, and errors when a failure occurs.
- Demonstrates Clean Architecture layering and a basic repository pattern.

---

## Project structure
The `lib/` folder is organized by Clean Architecture layers and by feature:

```text
lib/
  core/
    connection/            # Connectivity abstraction
    database/
      API/                 # API client & endpoints (dio)
      Cache/               # SharedPreferences helper
    errors/                # Exceptions/Failure models
    params/                # Request parameter objects

  feature/
    user/
      data/                # Data sources + models + repo implementation
        data_source/
        models/
        repo/
      domain/              # Entities + repository contract + use cases
        entites/
        repo/
        usecases/
      presentation/        # UI layer (Cubit, screens, widgets)
        cubit/
        screens/
        widgets/

  main.dart                # App entry; wires root screen
```

### Layer responsibilities
- **domain**: pure business rules. Contains `entities`, `usecases`, and repository interfaces.
- **data**: talks to the outside world (API, cache). Implements repository contracts and maps models to domain entities.
- **presentation**: Flutter UI + state management (`Cubit`), converts domain outputs into UI state.

---

## Data flow overview
1. UI (`presentation`) triggers `UserCubit.eitherFailureOrUser(id)`.
2. `UserCubit` calls the `GetUser` use case (`domain/usecases/get_user.dart`).
3. `GetUser` depends on `UserRepo` (interface in domain), implemented by `UserRepoImpl` (`data/repo/user_repo_impl.dart`).
4. `UserRepoImpl` chooses a data source:
   - `user_remote_data_source.dart` via `DioConsumer` (`core/database/API/dio_consumer.dart`) against `EndPoints.user`.
   - `user_local_data_source.dart` via `CacheHelper` (`core/database/Cache/cache_helper.dart`) if applicable.
5. Results are mapped to domain `UserEntity` (from data `UserModel`) and returned as `Either<Failure, UserEntity>`.
6. `UserCubit` emits `GetUserLoading`, `GetUserSuccessfully`, or `GetUserFailure` to drive the UI.

Connectivity is provided by `NetworkInfoImpl` (`core/connection/network_info.dart`) using `data_connection_checker_tv`, exposing `isConnected` and `onConnectionChange`.

---

## Key files
- `lib/main.dart`: App entry; initializes cache and shows `UserScreen`.
- `lib/core/database/API/end_points.dart`: Base URL and endpoint keys.
- `lib/core/database/API/dio_consumer.dart`: Configured singleton `dio` client.
- `lib/feature/user/presentation/screens/user_screen.dart`: Root screen with connectivity handling and state consumption.
- `lib/feature/user/presentation/cubit/`: Cubit + state definitions.

---

## Configuration
- API: Uses public `jsonplaceholder` (no keys). To change the base URL or paths, edit `EndPoints` in `lib/core/database/API/end_points.dart`.
- Assets: Lottie files under `assets/` are declared in `pubspec.yaml` (`assets/`).
- Icons: Controlled via `flutter_launcher_icons` section in `pubspec.yaml`.

---

## Extending the app (example workflow)
To add a new feature following the same architecture:
1. Define a domain `Entity`, `UseCase`, and repository interface in `feature/<new>/domain`.
2. Implement `data` models, mappers, and data sources (remote/local) in `feature/<new>/data`.
3. Implement `RepoImpl` bridging data sources to the domain repository interface.
4. Create a `Cubit` (or `Bloc`) and states in `feature/<new>/presentation/cubit`.
5. Build screens/widgets to render states and trigger use cases.

---

## Vedio demo:

https://github.com/user-attachments/assets/7c471f85-9668-4470-a9b4-1e77f3093384



- API provided by [JSONPlaceholder](https://jsonplaceholder.typicode.com/).
- Flutter documentation: [docs.flutter.dev](https://docs.flutter.dev/).
