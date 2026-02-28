# Daraz-style Product Listing (Single Scroll Architecture)

This project demonstrates a **Daraz-style product listing screen** built with Flutter, focusing **not on UI polish**, but on **correct scroll architecture and gesture coordination**.

The implementation strictly follows interview-level constraints and is designed to showcase **senior-level understanding of scrolling and gestures in Flutter**.

---

## ✅ Interview Constraints Satisfied

- Exactly **ONE vertical scrollable**
- Collapsible header (banner + search bar)
- Sticky `TabBar` that remains visible after collapse
- Predictable horizontal tab navigation
- Pull-to-refresh from any tab
- No scroll conflicts or jitter
- Fully sliver-based layout

---

## 📱 Features Implemented

### Core Screen
- Collapsible header using `SliverAppBar`
- Sticky `TabBar` using `SliverPersistentHeader`
- Product grid per category
- Pull-to-refresh works from any scroll position
- Horizontal swipe to switch tabs
- Clean, unified sliver-based layout

### Authentication & Profile
- Login screen using FakeStore API
- Successful login navigates to Home screen
- User profile screen displaying basic user information

---

## 🧠 Architecture Overview

### Why `CustomScrollView` (NOT `NestedScrollView`)

This project uses a **single `CustomScrollView`** as the **only vertical scroll owner**.

**Why this choice:**
- `NestedScrollView` introduces **multiple vertical scroll positions**
- `PageView`, `ListView`, or `GridView` per tab violates the  
  **“exactly ONE vertical scrollable”** requirement
- Slivers allow the header, tabs, and content to exist in **one unified scroll tree**

✔ **Result:**  
Smooth scrolling, no gesture conflicts, stable scroll position, and predictable behavior.

---

## 📜 Mandatory Explanations

### 1️⃣ How horizontal swipe is implemented

- A **top-level `GestureDetector`** wraps the entire screen
- Horizontal swipe intent is detected using `onHorizontalDragEnd`
- Swipe **velocity** (not drag distance) is evaluated
- When a velocity threshold is crossed:
  - `TabController.animateTo()` is triggered
- Vertical scrolling is **never intercepted or affected**

**Why this approach:**
- `PageView` would introduce another scrollable and gesture owner
- `GestureDetector` allows intentional, controlled tab navigation
- Prevents diagonal swipe conflicts and scroll jitter

---

### 2️⃣ Who owns the vertical scroll and why

- The **root `CustomScrollView`** is the **sole vertical scroll owner**
- All content participates in the same scroll context:
  - `SliverAppBar`
  - `SliverPersistentHeader`
  - `SliverGrid`

**Why this matters:**
- Prevents scroll-inside-scroll bugs
- Pull-to-refresh works reliably from any tab
- Switching tabs does **not** reset or jump scroll position
- Fully complies with Flutter’s sliver-based scrolling model

---

### 3️⃣ Trade-offs / Limitations

**Trade-off**
- Horizontal swipe does not show partial page-drag visuals like `PageView`

**Why this is acceptable**
- Preserves strict single-scroll architecture
- Avoids fragile scroll synchronization
- Fully satisfies the interview’s architectural constraints

---

## ▶️ Run Instructions

```bash
flutter pub get
flutter run
