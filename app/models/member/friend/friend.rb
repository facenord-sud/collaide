# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: member_friend_friends
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

# -*- encoding : utf-8 -*-
class Member::Friend::Friend < ActiveRecord::Base

  belongs_to :user, :class_name => 'User'
end
