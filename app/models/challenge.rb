class Challenge < ActiveRecord::Base
  belongs_to :challenger, :class_name => "User"
  belongs_to :challengee, :class_name => "User"

  def to_s
    result = "#{challenger} has challenged #{challengee} on #{created_at.to_date}"
    if message.present?
      result += " \"#{message}\""
    end
    result
  end
end
