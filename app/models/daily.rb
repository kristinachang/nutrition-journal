class Daily < ActiveRecord::Base
	has_and_belongs_to_many :items
	belongs_to :user
	default_scope { order ('date ASC') }
end
