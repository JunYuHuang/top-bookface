require "digest/md5"

module GravatarApiLib
  def self.image_url(email)
    cleaned_email = email.downcase.delete(" ")
    hash = Digest::MD5.hexdigest(cleaned_email)
    "https://gravatar.com/avatar/#{hash}?d=wavatar"
  end
end
