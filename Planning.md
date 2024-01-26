# Planning

## MVP Requirements

- TLDR: basic full stack social media web app clone
- guest users can only view sign-in, sign-up pages
- reg. users can view all pages
- user authentication
  - use `Devise` gem
- user features
  - can be created
  - can send follow / friend requests to other users
  - create posts
    - text only
  - like posts
  - unlike posts
  - comment on posts
  - has index page
- follow features
  - can be viewed, updated
- post features
  - created by 1 user
  - displays
    - content (text)
    - author
    - comments
    - likes
  - has index page that shows all latest posts
    - from the current (logged in) user
    - from users the logged-in user follows
- comment features
  - can be created and viewed
- profile features
  - associated with 1 user
  - can be created and viewed
  - has profile photo / picture
    - from users who sign in using OmniAuth (i.e. GitHub account's profile picture) or auto-generated with Gravatar
  - has user's info
  - has posts
- sends welcome email to a new user who signs up
  - test with `letter_opener` gem
- deploy it live to a hosting provider
- set up an email provider and start sending real emails

## Extra Requirements

- allow image-body posts (URL or upload)
- allow profile picture upload and storage via Active Storage
- make post be either a text or a photo using a polymorphic association
- style it nicely
- user functions
  - update
  - delete
- follow functions
  - delete?
- post functions
  - update
  - delete
- comment functions
  - update
  - delete

## Subsystem / Service Specs

### `Follow` and `FollowRequest` Subsystem Specs

Definition(s):

- Users `uA` and `uB` are both:
  - registered users
  - signed in before and while they are using the app
  - are distinct users
- The `Follow` model is represented as the `follow` table in the database.
- The `FollowRequest` model is represented as the `follow_requests` table in the database.
- For user `uA` to be following user `uB` means:
  - There is a `follows` record that links users `uA` and `uB` via their primary keys.
  - User `uA` sent a follow request `frA` to user `uB`.
  - User `uB` accepted the request `frA` from user `uA`.
- For user `uA` to NOT be following user `uB` means:
  - There is NO `follows` record that links users `uA` and `uB` via their primary keys.
  - User `uA` may not have sent a follow request to user `uB`.
  - User `uA` may have sent a follow request to user `uB`.
  - If user `uA` sent a follow request `frA` to user `uB`,
    - User `uB` has rejected the request
    - OR User `uB` has not yet accepted the request
- For user `uA` to send a "follow request" `frA` to user `uB` means:
  - User `uA` is not following user `uB`.
  - Create the follow request `frA` in the database.
- For user `uA` to "unfollow" user `uB` means:
  - There is a `follows` record `fA` that indicates user `uA` is following `uB`.
  - Delete the `follows` record `fA` from the database.
- For user `uB` to reject a "follow request" `frA` from user `uA` means:
  - There is a `follows` record `fA` that indicates user `uA` is following `uB`.
  - Delete the `follows` record `fA` from the database.
- For user `uB` to accept a "follow request" `frA` from user `uA` means:
  - There is a `follows` record `fA` that indicates user `uA` is following `uB`.
  - Delete the `follows` record `fA` from the database.
  - Create the `follows` record `fA` that indicates that user `uA` is following user `uB`.

Constraint(s):

- A follow relation is unidirectional where one user `uA` is following another user `uB`.
- User `uA` can not directly or forcibly follow another user `uB`.
- User `uB` must first accept a follow request `frA` from user `uA` for there to be a `follows` record to exist that links them.
- User `uA` cannot unfollow a user `uB` if there is no `follows` record that indicates `uA` is following `uB`.
- User `uA` does not need consent from user `uB` if they want to unfollow `uB`.
- Users that send follow requests cannot unsend or delete any follow request(s) they have sent.
- Users that get follow requests can delete any follow request(s) that they get.
- A `follow_requests` record `frA` only exists if there is NO `follows` record that indicates user `uA` is following user `uB`.
- A `follow_requests` record `frA` does not exist if there IS a `follows` record that indicates user `uA` is following user `uB`.
- User `uA` can create 0 or 1 `follow_requests` record(s) at most for each followee that they want to follow.

### `Post` Subsystem Specs

Definition(s):

- Assumes the `User` Subsystem exists.
- Any user is registered and signed in while they are using the app.
- Users `uA` and `uB` are distinct users.
- Post `pA` is a post authored by user `uA`.
- The `Post` model is represented by the `posts` database table.
- A post is associated with one user (author).
- For a post `pA` to be authored by user `uA` means:
  - There is a `posts` record `pA` where its `author_id` field matches user `uA`'s `id` field.

Constraint(s):

- Any post is authored at most by one user.
- Any post is viewable by all users.
- Any user can create, edit, and delete their authored posts.
- Any user cannot edit or delete posts not authored by themselves.
- User `uA` cannot create a post `pB` on behalf of user `uB`; `uA` cannot trigger the creation of a post `pB` record whose `author_id` field matches user `uB`'s `id` field.

### `Like` Subsystem Specs

Definition(s):

- Assumes the `User` Subsystem exists.
- Assumes the `Post` Subsystem exists.
- Any user is registered and signed in while they are using the app.
- Users `uA` and `uB` are distinct users.
- Post `pA` is a post authored by user `uA`.
- The `Like` model is represented by the `likes` database table.
- Like `lA` is a like created by user `uA` on the post `pA`.
- A like is associated with one user and one post.
- For user `uA` to "like" a post `pA` means:
  - There is NO `likes` record `lA`
    - whose `liker_id` field matches user `uA`'s `id` field
    - whose `post_id` field matches post `pA`'s `id` field
  - Create the `likes` record `lA` that indicates that user `uA` liked post `pA`.
- For user `uA` to "unlike" a post `pA` means:
  - There IS a `likes` record `lA`
    - whose `liker_id` field matches user `uA`'s `id` field
    - whose `post_id` field matches post `pA`'s `id` field
  - Delete the `likes` record `lA` that indicates that user `uA` liked post `pA`.

Constraint(s):

- Only posts are likeable or unlikeable.
- A user can like or unlike a post.
- Any like is viewable by any user.
- Any post can be liked by each user at most 0 or 1 time(s).
- Any post can be liked by its own author.
- A user can like or unlike multiple, distinct posts.
- A user cannot like a post that they have already liked.
- A user cannot unlike a post that they have not liked yet.
- A user cannot like a post on behalf of another user.
- A user cannot unlike a post on behalf of another user.

### `Comment` Subsystem Specs

Definition(s):

- Assumes the `User` Subsystem exists.
- Assumes the `Post` Subsystem exists.
- Any user is registered and signed in while they are using the app.
- Users `uA` and `uB` are distinct users.
- Post `pA` is a post authored by user `uA`.
- The `Comment` model is represented by the `comments` database table.
- Comment `cA` is a comment authored by user `uA` on the post `pA`.
- A comment is associated with one user (author) and one post.
- For a comment `cA` to be authored by user `uA` means:
  - There is a `comments` record `cA` where its `author_id` field matches user `uA`'s `id` field.

Constraint(s):

- Only posts are commentable.
- Any user can comment on any post.
- Any user can comment on multiple, distinct posts.
- Any user can comment multiple times on the same post.
- Any comment is viewable by any user.
- Any comment can be edited or deleted only by its author.
- A user cannot comment on a post on behalf of another user.

### `User` Subsystem - Profile Update Specs

Definition(s):

- TODO

Constraint(s):

- TODO

## User Workflows

### User Registration

Assumption(s):

- User is not registered (no account).
- User is not signed in to the app.

Step(s):

1. User goes the root `/` page.
1. App redirects user to the `/users/sign_up` page.
1. User fills in input fields.
1. User clicks on `Register` button.
1. App creates user account as a new record in the database.
1. App signs in user.
1. App redirects user to the root `/` page.
1. `/` root page redirects to the posts index `/posts` page.

### User Follows Another User

1. TODO

### User Unfollows Another User

1. TODO

### User Accepts A Follow Request

1. TODO

### User Rejects A Follow Request

1. TODO

### User Views All (Relevant) Posts

Assumption(s):

- User `A` is signed in to the app.
- User `A` is following 0 or more other users.

Step(s):

1. User `A` goes to index `/` page.
1. App fetches and shows a list of all posts from user `A` and any users that have accepted user `A`'s follow request.

### User Views A Single Post

Assumption(s):

- User `A` is signed in to the app.

Step(s):

1. User `A` goes to index `/` page.
1. App fetches and shows a list of all posts from user `A` and any users that have accepted user `A`'s follow request.
1. User `A` clicks on the `View` link associated with a displayed post.
1. App redirects user to the post detail page `/posts/:id`.

### User Creates A Post

Assumption(s):

- User `A` is signed in to the app.

Step(s):

1. User `A` goes to index `/` page.
1. App fetches and shows a list of all posts from user `A` and any users that have accepted user `A`'s follow request.
1. User `A` clicks on the `Create Post` link / button.
1. App redirects user to the post new page `/posts/new`.
1. User fill outs the form fields for creating a new post.
1. User `A` clicks the `Submit` button.
1. App creates and saves the post in the database.
1. App redirects the user back to the post index page `/posts/:id`.

### User Edits A Post

Assumption(s):

- User `uA` is signed in to the app.
- Post `pA` is authored by user `uA`. If not, the app redirects the user `uA` back to the index page with an error message indicating that the user is not authorized to edit the post.

Step(s):

1. User `uA` goes to index `/` page.
1. App fetches and shows a list of all posts from user `uA` and any users that have accepted user `uA`'s follow request.
1. User `uA` clicks on the `Edit` link / button associated with post `pA`.
1. App redirects user to the post edit page `/posts/:id/edit`.
1. User `uA` fill outs the form fields for editing the post.
1. User `uA` clicks the `Submit` button.
1. App updates and saves the post `pA` in the database.
1. App redirects the user back to the post index page `/posts/:id`.

### User Deletes A Post

Assumption(s):

- User `uA` is signed in to the app.
- Post `pA` is authored by user `uA`. If not, the app redirects the user `uA` back to the index page with an error message indicating that the user is not authorized to edit the post.

Step(s):

1. User `uA` goes to index `/` page.
1. App fetches and shows a list of all posts from user `uA` and any users that have accepted user `uA`'s follow request.
1. User `uA` clicks on the `Delete` link / button associated with post `pA`.
1. App deletes the post `pA` from the database.
1. App redirects the user back to the posts index page `/posts`.

### User Likes A Post

Assumption(s):

- By default, any (registered) user follows themselves and this relation cannot be changed.
- User `uA` is signed in to the app.
- Post `pA` may or may not be authored by user `uA`.
- Post `pA` has not been liked by user `uA`.

Step(s):

1. User `uA` goes to index `/` page.
1. User `uA` clicks on the `Like` link associated with post `pA`.
1. App creates a Like in the database that associates the user `uA` with the post `pA`.
1. Without refreshing the page, the app updates the liked post `pA` 's displayed like counter.
1. Without refreshing the page, the app changes the `Like` link to an `Unlike` link.

### User Un-Likes A Post

Assumption(s):

- By default, any (registered) user follows themselves and this relation cannot be changed.
- User `uA` is signed in to the app.
- Post `pA` may or may not be authored by user `uA`.
- Post `pA` has been liked by user `uA`.

Step(s):

1. User `uA` goes to index `/` page.
1. User `uA` clicks on the `Unlike` link associated with post `pA`.
1. App deletes the Like in the database that associates the user `uA` with the post `pA`.
1. Without refreshing the page, the app updates the liked post `pA` 's displayed like counter.
1. Without refreshing the page, the app changes the `Unlike` link to a `Like` link.

### User Creates A Comment

1. TODO

### User Edits A Comment

1. TODO

### User Deletes A Comment

1. TODO

### App Creates a User (Profile)

1. App takes user's input fields (username, password, etc.)
1. App generates a profile picture using Gravatar.
1. App gets the URL to the Gravatar-generated picture.
1. App creates a new database record under the `users` table with the collection info.

### User Updates Their Profile (User Account)

1. TODO

## Data Models

For the most up-to-date data models, see the following:

- [Database Schema](./db/schema.rb)
- [User Model](./app/models/user.rb)
- [Follow Model](./app/models/follow.rb)
- [Follow Request Model](./app/models/follow_request.rb)
- [Post Model](./app/models/post.rb)

Models:

- User
- Follow
- FollowRequest
- Post
- Comment
- Like

### `User` Model

```
username:string [unique, 3-32 chars, present]
email:string [unique, present]
password:string [6-32 chars, present]
photo_url:string [present]
id:integer
created_at:datetime
updated_at:datetime

has_many posts
has_many likes
has_many comments
has_many followers via follows
has_many followees via follows
```

### `Follow` Model

```
followee_id:integer [present] (FK of `User.id`)
follower_id:integer [present] (FK of `User.id`)
id:integer
created_at:datetime
updated_at:datetime

belongs_to followee (user)
belongs_to follower (user)
```

### `FollowRequest` Model

```
requestee_id:integer [present] (FK of `User.id`)
requester_id:integer [present] (FK of `User.id`)
id:integer
created_at:datetime
updated_at:datetime

belongs_to requestee (user)
belongs_to requester (user)
```

### `Post` Model

```
author_id:integer [present] (FK of `User.id`)
body:text [1-255 chars, present]
id:integer
created_at:datetime
updated_at:datetime

belongs_to author (user)
has_many comments
has_many likes
```

### `Like` Model

```
post_id:integer [present] (FK of `Post.id`)
liker_id:integer [present] (FK of `User.id`)
id:[post_id, liker_id] (composite PK)
created_at:datetime
updated_at:datetime

belongs_to post
belongs_to liker (user)
```

### `Comment` Model

```
post_id:integer [present] (FK of `Post.id`)
author_id:integer [present] (FK of `User.id`)
body:text [1-255 chars, present]
id:integer
created_at:datetime
updated_at:datetime

belongs_to post
belongs_to author (user)
```

## Routes

```
# Required Routes
GET     / -> redirect to `/posts`
GET     /users/:id
GET     /users/:id/edit
PUT     /users/:id
GET     /users
GET     /users/sign_up
GET     /users/sign_in
POST    /users/sign_in
DELETE  /users/sign_out
POST    /follows
PUT     /follows/:id
GET     /posts
GET     /posts/:id/show
POST    /posts
GET     /posts/:id/new
PUT     /posts/:id
GET     /posts/:id/edit
DELETE  /posts/:id
POST    /likes/:id
DELETE  /likes/:id
GET     /comment/:id
POST    /comment
GET     /comment/new
PUT     /comment/:id
GET     /comment/:id/edit
DELETE  /comment/:id

# Extra Routes
TODO
```
