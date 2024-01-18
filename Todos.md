# Todos

## MVP Requirements

- [x] Point 1 (config app with PostgreSQL)
- [x] Point 2 (users must be logged in to access any pages)
- [x] Point 3 (do user auth with Devise gem)
- [ ] Point 4 (build user follows and follow requests systems)
- [ ] Point 5 (build posts system)
- [ ] Point 6 (build post likes system)
- [ ] Point 7 (build post comments system)
- [ ] Point 8 (post detail page)
- [ ] Point 9 (posts index page)
- [ ] Point 10 (user has profile picture)
- [ ] Point 11 (user detail / profile page)
- [ ] Point 12 (users index page)
- [ ] Point 13 (email new users who sign up)
- [ ] Point 14 (deploy app)
- [ ] Point 15 (set up email provider to send real emails)

## Extra Credit

- [ ] Point 1 (allow images in posts via URL or upload)
- [ ] Point 2 (allow profile pictures via Active Storage)
- [ ] Point 3 (allow posts to be either a text or a photo)
- [ ] Point 4 (style it nicely)

## Getting started

- [ ] Point 1 (plan an design data architecture)
- [ ] Point 2 (start the Git repo with the boilerplate Rails app)
- [ ] Point 3 (work on the requirements)
- [ ] Point 4 (create fake data with a custom database seed)

## Custom Todos

### Pre-planning Todos

- [x] Update README
- [x] Create detailed planning notes in `Planning.md`

### Simple Todos

- [x] Set up PostgreSQL config in Rails app

### User Authentication Todos

- [x] Add `User` model
- [x] Config user sign in with either username or email
  - [x] Generate database migration file that sets the `users.username` field to be unique
  - [x] Follow the rest of the steps in the [Devise Wiki Docs](https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address)
- [x] Config Devise to work with Hotwire / Turbo
- [x] Add `User` Sign-In function
- [x] Add `User` Sign-Out function
- [x] Customize `User` Sign In page
- [x] Customize `User` Sign Up page

### Basic (Forced / No Requests) Follow System Todos

- [ ] Write new database migration that creates a `follows` table
  - [ ] Add unique constraint to columns `followee_id` and `follower_id`
- [ ] Run database migration
- [ ] Add `Follow` model
- [ ] Add `Follow` controller
  - [ ] `#index`
  - [ ] `#create`
  - [ ] `#destroy`
- [ ] Add `Follow` routes
  - [ ] GET `/follows`
  - [ ] POST `/follows`
  - [ ] DELETE `/follows/:id`
- [ ] Add `Follow` views
  - [ ] `follows/index` that shows all the users the signed-in user is following and all the users the signed-in user is following.
- [ ] Update `users/index` view to show a list with links to all users
- [ ] Update `users/show` view to display the user's `username`, `email`, and a `Follow` or `Unfollow` button

### Uncategorized Todos

- [ ] Finish `User` views
  - [ ] `users/index`
  - [ ] `users/show`
- [ ] Finish `User` controller
  - [ ] `#index`
  - [ ] `#show`
  - [ ] `#edit`
- [ ] Finish `User` routes
  - [ ] GET `/users`
  - [ ] GET `/users/:id`
  - [ ] GET `/users/:id/edit`
  - [ ] POST `/users/:id`
- [ ] Create models
- [ ] Add database seed
