# frozen_string_literal: true

class PostDecorator < Draper::Decorator
  delegate_all

  def calculate_reading_time
    words_per_minute = 200
    words = object.body.split.size
    (words / words_per_minute.to_f).ceil
  end

  def reading_time
    minutes = calculate_reading_time
    "#{minutes} #{'minute'.pluralize(minutes)} read"
  end
end
