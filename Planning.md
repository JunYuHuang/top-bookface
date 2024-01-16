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

Assumption(s):

- By default, any (registered) user follows themselves and this relation cannot be changed.
- User `A` is signed in to the app.
- There is NO (pending, accepted, rejected) follow relation between user `A` and user `B`.

Step(s):

1. User `A` goes to users index `/users` page.
1. User `A` clicks on a `Follow` button associated with another user `B`.
1. App creates a new record in the `follows` table of the database for this new follow relation between users `A` and `B` with a default `status` of `pending`.
1. The clicked on `Follow` button is replaced by an `Unfollow` button.

### User Unfollows Another User

Assumption(s):

- By default, any (registered) user follows themselves and this relation cannot be changed.
- User `A` is signed in to the app.
- There IS a (pending, accepted, rejected) follow relation between user `A` and user `B`.
- The follow relation between user `A` and user `B` is one of the following from the set { `pending`, `rejected` }.

Step(s):

1. User `A` goes to users index `/users` page.
1. User `A` clicks on an `Unfollow` button associated with another user `B`.
1. App updates the record in the `follows` table of the database for this existing follow relation between users `A` and `B` with a `status` property of `pending`.
1. The clicked on `Unfollow` button is replaced by a `Follow` button.

### User Accepts A Follow Request

1. TODO

### User Rejects A Follow Request

1. TODO

### User Views All (Relevant) Posts

Assumption(s):

- By default, any (registered) user follows themselves and this relation cannot be changed.
- User `A` is signed in to the app.
- User `A` is following 0 or more other users.

Step(s):

1. User `A` goes to index `/` page.
1. App fetches and shows a list of all posts from user `A` and any users that have accepted user `A`'s follow request.

### User Views A Single Post

Assumption(s):

- By default, any (registered) user follows themselves and this relation cannot be changed.
- User `A` is signed in to the app.

Step(s):

1. User `A` goes to index `/` page.
1. App fetches and shows a list of all posts from user `A` and any users that have accepted user `A`'s follow request.
1. User `A` clicks on the `View` link associated with a displayed post.
1. App redirects user to the post detail page `/posts/:id`.

### User Creates A Post

Assumption(s):

- By default, any (registered) user follows themselves and this relation cannot be changed.
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

- By default, any (registered) user follows themselves and this relation cannot be changed.
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

- By default, any (registered) user follows themselves and this relation cannot be changed.
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

## Data Model

Models:

- User
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
status:string [present, 1 of { "pending", "accepted", "rejected" }]
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
user_id:integer [present] (FK of `User.id`)
id:integer
created_at:datetime
updated_at:datetime

belongs_to post
belongs_to user
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
