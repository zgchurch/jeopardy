class Word < ActiveRecord::Base
  validates_uniqueness_of :word
  def to_s
    text
  end

  def self.random
    order("RAND()").first
  end
end
