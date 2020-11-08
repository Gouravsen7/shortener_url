require 'nokogiri'
require 'open-uri'
require 'sidekiq-scheduler'

class FetchTitleJob < ApplicationJob
  queue_as :default

  def perform()
    ShortUrl.where(title: nil, created_at: DateTime.now - 24.hours).each do |record|
      begin
        doc = Nokogiri::HTML(URI.open(record.sanitize))
        title = doc.css('html head title').first.content
        record.title = title
      rescue Exception => e
        record.title = "Title not found"
      end
      record.save
    end
  end
end
