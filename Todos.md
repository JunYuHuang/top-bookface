# Todos

## MVP Requirements

- [x] Point 1 (config app with PostgreSQL)
- [x] Point 2 (users must be logged in to access any pages)
- [x] Point 3 (do user auth with Devise gem)
- [x] Point 4 (build basic user follows system + follow request system)
- [x] Point 5 (build posts system)
- [x] Point 6 (build post likes system)
- [x] Point 7 (build post comments system)
- [x] Point 8 (post detail page)
- [x] Point 9 (posts index page)
- [x] Point 10 (user has profile picture)
- [x] Point 11 (user detail / profile page)
- [x] Point 12 (users index page)
- [x] Point 13 (email new users who sign up)
- [ ] Point 14 (deploy app)
- [ ] Point 15 (set up email provider to send real emails)

## Extra Credit

- [ ] Point 1 (allow images in posts via URL or upload)
- [ ] Point 2 (allow profile pictures via Active Storage)
- [ ] Point 3 (allow posts to be either a text or a photo)
- [ ] Point 4 (style it nicely)

## Getting started

- [x] Point 1 (plan and design data architecture)
- [x] Point 2 (start the Git repo with the boilerplate Rails app)
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

- [ ] ~~Update `User` model~~
  - [ ] ~~`#can_create_post?`~~
- [x] Update `Posts` controller
  - [x] `#create` (create post if authorized else redirect)
  - [x] `#new` (show new page)
- [x] Update or add `Post` views
  - [x] `/posts/index` to have a `New Post` button
  - [x] `/posts/new` view
  - [x] `/posts/_form` partial view

### Post System - Part 4 Todos

Edit Post feature.

- [x] Update `User` model
  - [x] `#can_edit_post?`
- [x] Update `Posts` controller
  - [x] `#update` (update post if authorized else redirect)
  - [x] `#edit` (show edit page)
  - [x] `#show` (show edit link if authorized)
- [x] Update or add `Post` views
  - [x] `/posts/show` to show an `Edit Post` link if signed-in user is the author of the post
  - [x] `/posts/edit` view to reuse `/posts/_form` partial view

### Post System - Part 5 Todos

Delete Post feature.

- [x] Update `User` model
  - [x] `#can_delete_post?`
- [x] Update `Posts` controller
  - [x] `#destroy` (delete post if authorized else redirect)
  - [x] `#show` (check if sign-in user can delete post)
- [x] Update or add `Post` views
  - [x] `/posts/show` to show an `Delete Post` link if signed-in user is the author of the post

### Post System - Part 6 Todos

Update posts index page.

- [x] Update `posts/index` view
  - [x] Only show list of posts authored by the signed-in user and all users followed by the signed-in user by default
  - [x] List of posts should be ordered by descending (latest) date of when the post was created (`created_at`)
  - [x] Each post displayed should be its title as a clickable link
- [x] Update `shared/_header` partial view
  - [x] Update `Posts` link to go to index page but shows all posts

### Like System - Part 1 Todos

Create initial `Like` MVC.

- [x] Run Rails generator to create `Like` model
- [x] Update and run new database migration script to set up indices and foreign keys
- [x] Add associations to `Like` model
- [x] Add associations to `User` model
- [x] Add associations to `Post` model
- [x] Run Rails generator to create `Likes` controller for the following routes:
  - [x] POST `/likes` (`#create`)
  - [x] DELETE `/likes/:id` (`#destroy`)

### Like System - Part 2 Todos

Show like counter on post show page.

- [x] Update `Posts` controller
  - [x] `#show` (fetch count of likes)
- [x] Update `Posts` views
  - [x] `posts/show` (show count of likes)

### Like System - Part 3 Todos

Like post feature.

- [x] Update `User` model
  - [x] `#can_like_post?`
- [x] Update `Likes` controller
  - [x] `#create` (create like)
- [x] Add `Shared` partial views
  - [x] `shared/_like_form` view
- [x] Update `Post` controller
  - [x] `#show` (check if signed-in user can like post)
- [x] Update `Post` views
  - [x] `posts/show` (show like form / button)

### Like System - Part 4 Todos

Unlike post feature.

- [x] Update `User` model
  - [x] `#can_unlike_post?`
- [x] Update `Likes` controller
  - [x] `#destroy` (delete like)
- [x] Add `Shared` partial views
  - [x] `shared/_unlike_form` view
- [x] Update `Post` controller
  - [x] `#show` (check if signed-in user can unlike post)
- [x] Update `Post` views
  - [x] `posts/show` (show unlike form / button)

### Comment System - Part 1 Todos

Create initial `Comment` MVC.

- [x] Run Rails generator to create `Comment` model
- [x] Update new database migration script to set up indices and foreign keys
- [x] Add associations to `Comment` model
- [x] Add associations to `Post` model
- [x] Add associations to `User` model
- [x] Run Rails generator to create `Comments` controller and views for the following routes:
  - [x] POST `/posts/:post_id/comments` -> `#create` (no view)
  - [x] PUT `/posts/:post_id/comments/:id` -> `#update` (no view)
  - [x] GET `/posts/:post_id/comments/:id/edit` -> `#edit`
  - [x] DELETE `/posts/:post_id/comments/:id` -> `#destroy` (no view)

### Comment System - Part 2 Todos

Show comments on post show page.

- [x] Update `Posts` controller
  - [x] `#show()` (fetch comments for the specific post)
- [x] Add `Shared` views
  - [x] `shared/_comment` partial view
- [x] Update `Posts` views
  - [x] `posts/show` view (show list of comments)

### Comment System - Part 3 Todos

Create comment feature.

- [x] Update `Comments` controller
  - [x] `#create()` (create new `comments` record in db if valid)
- [x] Add `Shared` views
  - [x] `shared/_comment_form` partial view
- [x] Update `Posts` views
  - [x] `posts/show` view (show comment form)

### Comment System - Part 4 Todos

Edit comment feature.

- [x] Update `User` model
  - [x] `#is_comment_author?()` method
- [x] Update `Comments` controller
  - [x] `#update()` (update `comments` record in db if valid)
- [x] Update `Shared` views
  - [x] `shared/_comment` partial view
    - [x] show edit link if signed-in user is author of comment
- [x] Add `Comment` views
  - [x] `comments/edit` view (uses comment form)

### Comment System - Part 5 Todos

Delete comment feature.

- [x] Update `Comments` controller
  - [x] `#destroy()` (delete `comments` record from db if valid and authorized)
- [x] Update `Shared` views
  - [x] `shared/_comment` partial view
    - [x] show delete link if signed-in user is author of comment
- [x] Update `Post` views
  - [x] `posts/show` (pass in `can_delete` local var to rendered partial view `shared/_comment`)

### User Profile Feature - Part 1 Todos

Assign Gravatar-generated profile pictures to users.

- [x] Set up autoloading for modules located in `/lib`
- [x] Create `GravatarAPILib` module in `/lib`
  - [x] Write `#image_url(email)` class method
    - [x] downcases `email`
    - [x] removes all whitespace from `email`
    - [x] returns `email` as a SHA256 hash
    - [x] returns the correct image url associated with an email hash
- [x] Update all `users` DB records that have a null `photo_url` field to be set to the gravatar URL that has their profile picture
- [x] Add fallback user profile picture as asset
- [x] Update `User` views
  - [x] `users/show`
    - [x] Show user's profile image
    - [x] Show user's overview stats (date joined, email address, etc.)
    - [x] Show user's posts

### User Profile Feature - Part 2 Todos

Assign Gravatar-generated profile pictures by default to newly created / registered users.

- [x] Generate `devise/registrations` controller
- [x] Update `devise/registrations` controller
  - [x] Update `#create` to auto-fill in the `photo_url` field for newly created users

### User Welcome Email Feature - Part 1 Todos

Send a welcome email to a new user's email address when they sign up.

- [x] Configure mailer in Rails
  - [x] Generate the `User` mailer
  - [x] Create the mailer view (email template)
- [x] Update `users/registrations` controller
  - [x] Update `#create` action to send the email after the user record is created in the database
- [x] Install and configure `letter_opener` gem
- [x] Test the feature in dev mode using the `letter_opener` gem

### Tests - Part 1 Todos

Set up basic testing infrastructure

- [x] Update auto-generated tests so they do not fail automatically
- [x] Write any test that passes
- [x] Install and configure `guard` gem to continously run tests in the background

### Tests - Part 2 Todos

Write a few basic unit tests.

- [x] Write unit tests
  - [x] Test if `User#followers` association works
  - [x] Test if `User#followees` association works
  - [x] Test if `User#sent_follow_requests` association works
  - [x] Test if `User#received_follow_requests` association works
  - [x] Test if `User#posts` association works
  - [x] Test if `User#comments` association works
  - [x] Test if `User#likes` association works

### Tests - Part 3 Todos

Write a few basic integration tests.

- [x] Write integration tests
  - [x] Test if visiting the GET `/` page redirects to the `/users/sign_in` page if the user is not signed in
  - [x] Test if vsiting the `/` page loads correctly if the user is signed in
  - [x] Test if the `/users/sign_in` page loads if the user is not signed in
  - [x] Test if visiting the `/users/sign_in` page redirects to `/` if the user is signed in
  - [x] Test if the `/users/sign_up` page loads correctly regardless of if the user is signed in or not
  - [x] Test if visiting the `/users/sign_up` page redirects to `/` if the user is signed in
  - [x] Test if the GET `/posts/:id` page loads correctly if there is a signed-in user

### Production Deployment - Part 1 Todos

Deploy the application live hosted on Fly.io

- [ ] TODO

### Database Optimisation Todos

- [ ] Find and fix N + 1 queries
  - [ ] Checking if the signed-in user can send a follow request to each user in the `users` table.
  - [ ] Querying all the posts authored by users followed by the signed-in user and by the signed-in user themselves

### Nice-To-Have Todos

- [ ] Replace certain SSR forms with client-side Turbo forms / links / buttons for SPA-like UX
  - [ ] `Follow` form / button
  - [ ] `Unfollow` form / button
  - [ ] `New Post` form
  - [ ] `Edit Post` form
  - [ ] `Like` form / button
  - [ ] `Unlike` form / button
  - [ ] `New Comment` form
  - [ ] `Update Comment` form
- [ ] Add database seed
