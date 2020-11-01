require 'uri'

class ShortUrl < ApplicationRecord
  
  validates_presence_of :original_url
  validates :original_url, format: URI::regexp(%w[http https])
  
  validates_length_of :original_url, in: 3..255

  before_create :generate_short_url, :sanitize
  
  def generate_short_url
    @slugs ||= self.class.pluck(:slug)
    uri = URI(original_url)
    initials = uri.host.split('.')[-2]
    slug_string = initials.first + initials.last
    slug_string += SecureRandom.urlsafe_base64(3)
    generate_short_url if @slugs.include?(slug_string)
    self.slug = slug_string
  end

  def sanitize
    original_url.strip!
    sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
    self.original_url = "http://#{sanitize_url}"
  end
  
end
