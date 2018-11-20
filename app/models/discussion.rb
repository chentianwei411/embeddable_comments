class Discussion < ApplicationRecord
  has_many :comments

  def self.by_url(url)
    uri = url.split("?").first
    uri = url.split("#").first
    uri.sub!(/\/$/, '')

    where(url: uri).first_or_create
  end
end
