
# 📚 Bookly App

A modern and powerful Flutter application for discovering, viewing, and saving books.  
**Built with clean architecture**, real-time API fetching, smooth pagination, local storage via Hive, and a beautiful animated splash screen.  
This app ensures a seamless user experience with robust error handling and clean code structure.

---

## 🚀 Features

✅ Splash screen with animation  
✅ Fetch books from API with pagination  
✅ Save favorite books using **Hive local storage**  
✅ Search books by title  
✅ Detailed book info screen  
✅ Elegant and responsive UI  
✅ Full error handling for all failure cases  
✅ Based on **Clean Architecture principles**

---

## 📸 Screenshots

<div align="center">

<table>
  <tr>
    <td><img src="assets/screen_shots/splash.jpg" width="220"/></td>
    <td><img src="assets/screen_shots/programming_books.jpg" width="220"/></td>
    <td><img src="assets/screen_shots/sports_books.jpg" width="220"/></td>
  </tr>
  <tr>
    <td><b>Splash Screen</b></td>
    <td><b>Programming Books</b></td>
    <td><b>Sports Books</b></td>
  </tr>
</table>

<br/>

<table>
  <tr>
    <td><img src="assets/screen_shots/search.jpg" width="220"/></td>
    <td><img src="assets/screen_shots/book_details.jpg" width="220"/></td>
  </tr>
  <tr>
    <td><b>Search Screen</b></td>
    <td><b>Book Details</b></td>
  </tr>
</table>

</div>


---

## 🧱 Project Structure

```

lib/
├── core/
├── features/
│   ├── home/
│   ├── search/
│   └── book\_details/
├── main.dart

````

Organized using **Clean Architecture**:  
- `Domain`: entities, use cases  
- `Data`: models, repositories, API  
- `Presentation`: UI + Cubits

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **Hive** – for local caching
- **Dio** – for API integration
- **Cubit (flutter_bloc)** – for state management
- **GetIt** – for dependency injection
- **Custom error handling classes**
- **ScreenUtil** – for responsive design

---

## ▶️ Getting Started

1. **Clone the repo**

```bash
git clone https://github.com/yourusername/bookly_app.git
cd bookly_app
````

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run
```

---