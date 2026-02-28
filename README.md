# Daraz-style Product Listing (Single Scroll Architecture)

This project demonstrates a **Daraz-style product listing screen** built with Flutter, focusing **not on UI polish**, but on **correct scroll architecture and gesture coordination**.

The implementation strictly follows interview-level constraints and is designed to showcase **senior-level understanding of scrolling and gestures in Flutter**.

🚀 [Live Demonstration](https://drive.google.com/file/d/1zXEDUYbIZwMa6CkUDIcWYQa6oQ7RQVX6/view?usp=sharing)

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

- Horizontal swipe is handled using a `PageView`
- `PageView` manages swipe velocity and gesture detection internally
- `onPageChanged` is used to synchronize the `TabController`
- Vertical scrolling is isolated by disabling inner scroll physics

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
- Uses `PageView` for horizontal navigation, which introduces an additional
  horizontal scrollable alongside the main vertical `CustomScrollView`

**Why acceptable here**
- Inner vertical scrolling is explicitly disabled
- Vertical scroll ownership remains predictable
- Horizontal swipe experience feels natural and responsive

---

## ▶️ Run Instructions

```bash
flutter pub get
flutter run
