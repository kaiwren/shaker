class GuessListener < ActiveRecord::Base
  belongs_to  :target_user, :class_name => 'User'
  belongs_to  :listening_user, :class_name => 'User'

  validates_uniqueness_of :target_user_id,  :scope => :listening_user_id, :message => 'You can only do this once, meh...'
end
