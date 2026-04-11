# FitKarma — Provider Organization & Architecture

This document outlines how Riverpod providers are organized within the FitKarma codebase.

## 1. Directory Structure

Providers are co-located with their relevant features wherever possible, or placed in `lib/core/di` for global services.

- `lib/core/di/providers.dart`: Global infrastructure providers (Appwrite, Drift Database).
- `lib/features/[feature]/data/[feature]_repository.dart`: Repository providers.
- `lib/features/[feature]/presentation/[feature]_controller.dart`: UI state/logic controllers (AsyncNotifier).
- `lib/features/[feature]/domain/`: Domain-specific logic providers (e.g., `festivalDietProvider`).

## 2. Global Infrastructure Providers

| Provider | Path | Description |
|---|---|---|
| `appwriteClientProvider` | `lib/core/network/appwrite_service.dart` | Singleton Appwrite client with cert pinning. |
| `databaseProvider` | `lib/core/di/providers.dart` | Singleton Drift database instance. |
| `authRepositoryProvider` | `lib/features/auth/data/auth_repository.dart` | Auth actions (login, register, etc). |
| `currentUserProvider` | `lib/features/auth/data/auth_repository.dart` | Current logged-in user. |

## 3. Scoping & Lifecycle

### @riverpod Generator
We use the `riverpod_generator` package for all new providers. This ensures:
- Type safety.
- Proper disposal when not in use (via `autoDispose` which is the default).
- Cleaner syntax.

### Manual Disposal
For providers wrapping long-lived resources (like streams or database connections), we ensure they are correctly disposed of using `ref.onDispose`.

### State Immutability
All controllers should use immutable state classes (e.g., `DashboardData`) to ensure predictable UI updates.

## 4. Error Handling (AsyncValue)

All providers that perform asynchronous tasks (Drift queries, Appwrite calls) must return `AsyncValue`.
The UI must handle these states using:
- `data`: Normal UI.
- `loading`: Shimmer or indicator.
- `error`: `ErrorRetryWidget`.

## 5. Dependency Injection

Use `ref.watch` to inject dependencies:
```dart
@riverpod
class MyController extends _$MyController {
  @override
  Future<MyData> build() async {
    final db = ref.read(databaseProvider); // Use read for services
    final user = await ref.watch(currentUserProvider.future); // Use watch for reactive data
    ...
  }
}
```
