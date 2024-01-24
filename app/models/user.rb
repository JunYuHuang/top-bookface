class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login

  has_many(
    :followee_follows, class_name: "Follow", foreign_key: "followee_id"
  )
  has_many(
    :follower_follows, class_name: "Follow", foreign_key: "follower_id"
  )
  has_many(
    :followers, through: :followee_follows, class_name: "User"
  )
  has_many(
    :followees, through: :follower_follows, class_name: "User"
  )
  has_many(
    :sent_follow_requests, class_name: "FollowRequest", foreign_key: "requester_id"
  )
  has_many(
    :received_follow_requests, class_name: "FollowRequest", foreign_key: "requestee_id"
  )

  validates(
    :username, presence: true, uniqueness: { case_sensitive: false }
  )

  validates_format_of(
    :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  )

  validate :validate_username

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h)
        .where([
          "lower(username) = :value OR lower(email) = :value",
          { :value => login.downcase }
        ])
        .first
    elsif (
      conditions.has_key?(:username) ||
      conditions.has_key?(:email)
    )
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, invalid)
    end
  end

  def is_same_user?(id)
    self.id == id.to_i
  end

  def can_view_follow_requests?(user_id)
    is_same_user?(user_id)
  end

  def can_send_follow_request?(args)
    args => { requestee_id:, requester_id: }
    return false if is_same_user?(requestee_id)
    return false unless is_same_user?(requester_id)
    return false unless User.exists?(requestee_id)
    return false if FollowRequest.where(
      requestee_id: requestee_id,
      requester_id: self.id,
    ).exists?
    !Follow.where(
      followee_id: requestee_id,
      follower_id: self.id,
    ).exists?
  end

  def can_follow?(user_id)
    return false if is_same_user?(user_id)
    return false if Follow.where(
      followee_id: user_id,
      follower_id: self.id,
    ).exists?
    !FollowRequest.where(
      requestee_id: user_id,
      requester_id: self.id,
    ).exists?
  end

  # TODO - replace `#can_follow?` with a method that returns a list of followable user id's whilst minimizing DB calls (prevent N+1 query problem)
  def followable_user_ids
    # `all_ids` = list of all `users.id` in `users` table not equal to `self.id`
    # filter out all `id`'s from `all_ids` for all `follows` rows where `follows.follower_id` equals `self.id`
    # filter out all `id`'s from `all_ids` for all `follow_requests` rows where `follow_requests.requester_id` equals `self.id`
    # return `all_ids` as a set
  end

  def can_unfollow?(args)
    args => { followee_id:, follower_id: }
    return false if is_same_user?(followee_id)
    return false unless is_same_user?(follower_id)
    return false unless User.exists?(followee_id)
    Follow.where(
      followee_id: followee_id,
      follower_id: self.id,
    ).exists?
  end

  def can_accept_follow_request?(args)
    args => { requestee_id:, requester_id: }
    return false if is_same_user?(requester_id)
    return false unless is_same_user?(requestee_id)
    return false if Follow.where(
      followee_id: requestee_id,
      follower_id: requester_id,
    ).exists?
    FollowRequest.where(
      requestee_id: requestee_id,
      requester_id: requester_id,
    ).exists?
  end

  def can_reject_follow_request?(args)
    can_accept_follow_request?(args)
  end
end
