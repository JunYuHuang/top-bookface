# Todos

## MVP Requirements

- [x] Point 1 (config app with PostgreSQL)
- [x] Point 2 (users must be logged in to access any pages)
- [x] Point 3 (do user auth with Devise gem)
- [ ] Point 4 (build basic user follows system + follow request system)
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

- [x] Add `Follow` model
- [x] Run database migration that creates a `follows` table
  - [x] Add unique constraint to columns `followee_id` and `follower_id`
  - [x] Update database migration script
  - [x] Run database migration script
- [x] Add association in `User` model to access followers
- [x] Add association in `User` model to access followees
- [x] Add association in `Follow` model to access follower
- [x] Add association in `Follow` model to access followee
- [x] Add `Follow` controller
  - [x] `#index`
  - [x] `#create`
  - [x] `#destroy`
- [x] Add `Follow` routes
  - [x] GET `/follows`
  - [x] POST `/follows`
  - [x] DELETE `/follows/:id`
- [x] Add `Follow` views
  - [x] `follows/index` that shows all the users the signed-in user is following and all the users the signed-in user is following.
- [x] Update `users/index` view to show a list with links to all users
- [x] Update `users/show` view to display the user's `username` and a `Follow` or `Unfollow` button
- [x] Fix follow form (in `users/show` view) and route handler
- [x] Fix unfollow form (in `users/show` view) and route handler

### Advanced Follow System + Follow Request System Todos

- [x] Add `FollowRequest` model (generates migration script)
- [x] Update and run a database migration script that creates a `follow_requests` table
  - [x] Index and add unique constraint to columns `requestee_id` and `requester_id`
  - [x] Set FKs that point to `users` tables
- [x] Set up association(s) so `User` model can access follow requesters (optional)
- [ ] Update `Follow` controller
  - [x] `#index` (see follows and followers)
  - [ ] `#create` (accept follow + delete follow request)
    - [ ] if signed-in user is unauthorized, refresh page with unauthorized message
  - [ ] `#destroy` (unfollow)
    - [ ] if signed-in user is unauthorized, refresh page with unauthorized message
- [x] Update `Follow` routes
  - [x] GET `/users/:user_id/follows`
  - [ ] POST `/users/:user_id/follows`
    - [ ] if signed-in user is unauthorized, refresh page with unauthorized message
  - [ ] DELETE `/users/:user_id/follows/:id`
    - [ ] if signed-in user is unauthorized, refresh page with unauthorized message
- [x] Update `Follow` views
  - [x] `/users/:user_id/follows/index`
    - [x] show followees and followers for user with id `:user_id`
- [x] Add `FollowRequest` controller
  - [x] `#index` (see received follow requests)
    - [x] if signed-in user does not have id `:user_id`, redirect to index page b/c user is not authorized to see them
  - [x] `#create` (send follow request)
    - [x] if signed-in user is unauthorized, redirect to root
  - [x] `#destroy` (reject follow request)
    - [x] if signed-in user is unauthorized, redirect with unauthorized message
- [ ] Add `FollowRequest` routes
  - [x] GET `/users/:user_id/follow_requests`
  - [x] POST `/users/:user_id/follow_requests`
  - [ ] DELETE `/users/:user_id/follow_requests/:id`
- [ ] Add `FollowRequest` views
  - [ ] `users/:user_id/follow_requests/index`
    - [x] shows a list of all users that the user with id `:user_id` sent follow requests to
    - [x] shows a list of all the users that sent a follow request to the user with id `:user_id`
    - [ ] accept request form per shown user
    - [ ] reject request form per shown user
- [ ] Update `User` model
  - [x] Add `is_same_user?` helper method
  - [x] Add `can_view_follow_requests?` helper method
  - [x] Add `can_send_follow_request_to?` helper method
  - [ ] Add `can_accept_follow_request?` helper method
  - [x] Add `can_unfollow?` helper method
  - [ ] Add `can_reject_follow_request?`
- [ ] Update `User` views
  - [x] `users/:id/show`
    - [x] use `shared/_follow_request_form` partial view
    - [x] use `shared/_unfollow_form` partial view
  - [ ] `users/`
    - [ ] follow request form for all users that are not the signed-in user, that the signed-in user is not following, that the signed-in user has sent a follow request that has been rejected
- [ ] Update `shared` views
  - [x] `shared/_header`
    - [x] Update `Follow Requests` link
    - [x] Move follow form from `users/show` view into `shared/_follow_request_form`
    - [x] Move unfollow form from `users/show` view into `shared/_unfollow_form`

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
