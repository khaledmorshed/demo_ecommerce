# Daraz-style Product Listing (Single Scroll Architecture)

This project demonstrates a **Daraz-style product listing screen** built with Flutter, focusing **not on UI**, but on **correct scroll architecture and gesture coordination**.

The implementation strictly follows the interview constraints:
- Exactly **ONE vertical scrollable**
- Sticky collapsible header
- Predictable horizontal tab navigation
- No scroll conflicts or jitter

---

## 📱 Features Implemented

### Core Screen
- Collapsible header (banner + search)
- Sticky `TabBar` that remains visible after collapse
- Product grid per category
- Pull-to-refresh from any tab
- Horizontal swipe to switch tabs
- Clean sliver-based layout

### Authentication
- Login screen using FakeStore API
- Successful login navigates to Home screen
- User profile screen displaying basic user information

---

## 🧠 Architecture Overview

### Why `CustomScrollView` (NOT `NestedScrollView`)
This project uses a **single `CustomScrollView`** as the **only vertical scroll owner**.

Why?
- `NestedScrollView` introduces **multiple scroll positions**
- `PageView` or `ListView` per tab violates the “single scrollable” rule
- Slivers allow the header, tabs, and content to live in one unified scroll tree

✔ Result: smooth scrolling, no jitter, predictable behavior

---

## 📜 Mandatory Explanations

### 1️⃣ How horizontal swipe is implemented

- A top-level `GestureDetector` wraps the entire screen
- Horizontal swipe velocity is detected using `onHorizontalDragEnd`
- When the swipe crosses a velocity threshold:
  - `TabController.animateTo()` is triggered
- Vertical scrolling is **not** affected

Why this approach?
- `PageView` would introduce another scrollable
- GestureDetector allows intentional, controlled tab switching

---

### 2️⃣ Who owns the vertical scroll and why

- The **root `CustomScrollView`** is the **only vertical scroll owner**
- All content is rendered using:
  - `SliverAppBar`
  - `SliverPersistentHeader`
  - `SliverGrid`

Why this matters:
- Prevents scroll-inside-scroll bugs
- Ensures pull-to-refresh works everywhere
- Guarantees scroll position is preserved when switching tabs

---

### 3️⃣ Trade-offs / Limitations

**Trade-off**
- Horizontal swipe does not show partial page dragging like `PageView`

**Why acceptable**
- Preserves architectural correctness
- Prevents gesture conflicts
- Meets the “exactly one scrollable” requirement

---

## ▶️ Run Instructions

```bash
flutter pub get
flutter run
