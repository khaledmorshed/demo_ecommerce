# Daraz-style Product Listing Flutter Implementation

This project implements a high-performance, sliver-based product listing screen with a collapsible header and sticky tabs, mimicking the Daraz E-commerce app.

## Key Features
- **Sliver Architecture**: Uses `NestedScrollView` to coordinate between a collapsible global header and tab-specific content.
- **State Management**: Built with `GetX` for clean separation of concerns (MVVM).
- **API Integration**: Fetches real-time data from [Fakestore API](https://fakestoreapi.com/).
- **Sticky Tabs**: Custom `SliverPersistentHeaderDelegate` for a smooth pinning effect.
- **Auth Flow**: Simple login and profile display using the API.

## Mandatory Explanation

### 1. How horizontal swipe was implemented
Horizontal swiping between tabs is handled by the `TabBarView` widget placed in the `body` of the `NestedScrollView`. `TabBarView` internally uses a `PageView`, which captures horizontal drag gestures. These gestures are natively separated from the vertical scroll gestures by the Flutter framework, ensuring a smooth transition between categories without conflicting with the vertical content scroll.

### 2. Who owns the vertical scroll and why?
The **`NestedScrollView`** owns and coordinates the vertical scroll. 
- It maintains an **Outer Controller** that handles the expansion and contraction of the `SliverAppBar` (the banner and search bar).
- Once the header is collapsed and the `TabBar` is pinned, the scroll gesture is transparently forwarded to the **Inner ScrollView** (the `CustomScrollView` inside the currently active tab).
- This "dual-ownership" coordinated by `NestedScrollView` is what allows for the "single vertical scroll" experience while having independent tab views.

### 3. Trade-offs or limitations
- **Scroll Synchronization**: In this implementation, each tab maintains its own scroll position (using `PageStorageKey`). If the user scrolls down on Tab 1 and then switches to Tab 2, Tab 2 will start at the top (or its last position). While typical for E-commerce, if strict synchronization was required (e.g., all tabs move together), a shared `ScrollController` or manual offset syncing would be necessary, which adds significant complexity and potential performance overhead.
- **RefreshIndicator**: The `RefreshIndicator` wraps the entire `NestedScrollView`. This ensures pull-to-refresh works from any tab/position. However, if a more granular "refresh only this tab" behavior was needed, each inner `CustomScrollView` would require its own logic, which might conflict with the `NestedScrollView`'s outer scroll physics.

## Getting Started
1. Run `flutter pub get`
2. Run `flutter run`
3. Tap the profile icon to login (Demo credentials: `mor_2314` / `83r5^_`)
