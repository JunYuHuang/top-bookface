# Todos

## MVP Requirements

- [x] Point 1 (config app with PostgreSQL)
- [x] Point 2 (users must be logged in to access any pages)
- [x] Point 3 (do user auth with Devise gem)
- [x] Point 4 (build basic user follows system + follow request system)
- [ ] Point 5 (build posts system)
- [ ] Point 6 (build post likes system)
- [ ] Point 7 (build post comments system)
- [ ] Point 8 (post detail page)
- [ ] Point 9 (posts index page)
- [ ] Point 10 (user has profile picture)
- [ ] Point 11 (user detail / profile page)
- [x] Point 12 (users index page)
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
- [x] Update `Follow` controller
  - [x] `#index` (see follows and followers)
  - [x] `#create` (accept follow + delete follow request)
    - [x] if signed-in user is unauthorized, redirect with unauthorized message
  - [x] `#destroy` (unfollow)
    - [x] if signed-in user is unauthorized, redirect with unauthorized message
- [x] Update `Follow` routes
  - [x] GET `/users/:user_id/follows`
  - [x] POST `/users/:user_id/follows`
  - [x] DELETE `/users/:user_id/follows/:id`
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
- [x] Add `FollowRequest` routes
  - [x] GET `/users/:user_id/follow_requests`
  - [x] POST `/users/:user_id/follow_requests`
  - [x] DELETE `/users/:user_id/follow_requests/:id`
- [x] Add `FollowRequest` views
  - [x] `users/:user_id/follow_requests/index`
    - [x] shows a list of all users that the user with id `:user_id` sent follow requests to
    - [x] shows a list of all the users that sent a follow request to the user with id `:user_id`
    - [x] accept request form per shown user
    - [x] reject request form per shown user
- [x] Update `User` model
  - [x] Add `is_same_user?` helper method
  - [x] Add `can_view_follow_requests?` helper method
  - [x] Add `can_send_follow_request?` helper method
  - [x] Add `can_accept_follow_request?` helper method
  - [x] Add `can_unfollow?` helper method
  - [x] Add `can_reject_follow_request?` helper method
- [x] Update `User` views
  - [x] `users/show`
    - [x] use `shared/_follow_request_form` partial view
    - [x] use `shared/_unfollow_form` partial view
  - [x] `users/index`
    - [x] follow request form for all users that are not the signed-in user, that the signed-in user is not following, that the signed-in user has sent a follow request that has been rejected
- [x] Update `shared` views
  - [x] `shared/_header`
    - [x] Update `Follow Requests` link
    - [x] Move follow form from `users/show` view into `shared/_follow_request_form`
    - [x] Move unfollow form from `users/show` view into `shared/_unfollow_form`

### Post System - Part 1 Todos

Create initial `Post` MVC.

- [x] Run Rails generator to create `Post` model
- [x] Update new database migration script to set up indices and foreign keys
- [x] Add associations to `Post` model
- [x] Add associations to `User` model
- [x] Run Rails generator to create `Posts` controller and views for the following routes:
  - [x] GET `/posts` (`#index`)
  - [x] POST `/posts` (`#create`)
  - [x] GET `/posts/:id` (`#show`)
  - [x] GET `/posts/new` (`#new`)
  - [x] PUT `/posts/:id` (`#update`)
  - [x] GET `/posts/:id/edit` (`#edit`)
  - [x] DELETE `/posts/:id/delete` (`#destroy`)
- [x] Update `/shared/_header` partial view
  - [x] Add `Posts` link
- [x] Make `/posts` the root path in routes

### Post System - Part 2 Todos

Basic posts index and detail pages.

- [x] Update `Posts` controller
  - [x] `#index`
  - [x] `#show`
- [x] Update or add `Post` views
  - [x] `/posts/index`
  - [x] `/posts/show` that shows:
    - [x] post body
    - [x] post author's username
    - [x] post create date
    - [x] post last update date

### Post System - Part 3 Todos

Create Post feature.

- [ ] Update `User` model
  - [ ] `#can_create_post?`
- [ ] Update `Posts` controller
  - [ ] `#create` (create post if authorized else redirect)
  - [ ] `#new` (show new page)
- [ ] Update or add `Post` views
  - [ ] `/posts/index` to have a `Create Post` button
  - [ ] `/posts/new` view
  - [ ] `/posts/_form` partial view

### Post System - Part 4 Todos

Edit Post feature.

- [ ] Update `User` model
  - [ ] `#can_edit_post?`
- [ ] Update `Posts` controller
  - [ ] `#update` (update post if authorized else redirect)
  - [ ] `#edit` (show edit page)
- [ ] Update or add `Post` views
  - [ ] `/posts/show` to show an `Edit Post` link if signed-in user is the author of the post
  - [ ] `/posts/edit` view to reuse `/posts/_form` partial view

### Post System - Part 5 Todos

Delete Post feature.

- [ ] Update `User` model
  - [ ] `#can_delete_post?`
- [ ] Update `Posts` controller
  - [ ] `#destroy` (delete post if authorized else redirect)
- [ ] Update or add `Post` views
  - [ ] `/posts/show` to show an `Delete Post` link if signed-in user is the author of the post

### Post System - Part 6 Todos

Update posts index page.

- [ ] Update `/posts/index` view
  - [ ] Only show list of posts authored by the signed-in user and all users followed by the signed-in user
  - [ ] Each post displayed should be its title as a clickable link

### Database Optimisation Todos

- [ ] Find and fix N + 1 queries
  - [ ] Checking if the signed-in user can send a follow request to each user in the `users` table.
  - [ ] TODO

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
