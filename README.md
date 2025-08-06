# Rewards Redemption Application

## Backend (Ruby on Rails)

* **API-Only Mode:** The project was initialized with `rails new --api` to create a lightweight, backend-only application, avoiding unnecessary frontend dependencies and middleware.

* **Database:** SQLite3 was used for its simplicity in development, as specified in the requirements.

* **Code Structure:**

  * Business logic for deducting points is encapsulated within a `deduct_points` method on the `User` model, promoting a fat model, thin controller approach.

  * Controllers are organized under an `Api` namespace for clarity.

  * API endpoints follow RESTful conventions.

* **Testing:** The application includes a comprehensive test suite using **RSpec**.


### Frontend (React)

* **React:** The frontend is a single-page application built with React and Vite.

## Assumptions Made

* **Single User Focus:** For simplicity and to meet the core requirements quickly, the frontend currently hardcodes a `CURRENT_USER_ID` of `1`. This bypasses the need for a full authentication system.

* **Basic Frontend State:** React's hooks are used for local component state. A more complex application might benefit from a dedicated state management library.

* **Development Environment:** The instructions assume a standard development environment with Ruby, Rails, Node.js, and npm/yarn installed.

* **Localhost Communication:** The frontend and backend are configured to communicate over `http://localhost` on specific ports (`3000` for Rails, `5173` for React). CORS is configured for this specific scenario.

* **One time Rewards:** A user can redeem a reward only once. Once the reward is redeemed, its removed from frontend. Adding backend validation could be an improvement here.

## What Could Have Been Better (Areas for Improvement)

For a production-ready application or to demonstrate a more comprehensive understanding, the following areas could be significantly improved:

* **Robust Authentication and Authorization:**

  * Implement a full authentication system (e.g., using **Devise** gem in Rails for backend and **JWT** for secure API communication).


* **Scalability and Performance:**

  * Implement **pagination and filtering** on API endpoints to handle large datasets.

  * Use a more robust production database like **PostgreSQL or MySQL**.

  * Add **API versioning** (e.g., `/api/v1/`).

* **Monitoring and Security:**

  * Integrate with logging and monitoring services (e.g., Sentry).

  * Implement **rate limiting** to prevent API abuse.