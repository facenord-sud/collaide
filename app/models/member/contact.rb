# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: member_contacts
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  date_of_birth :date
#  gender        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

# -*- encoding : utf-8 -*-
class Member::Contact < ActiveRecord::Base
  attr_accessible :date_of_birth, :first_name, :gender, :last_name

  belongs_to :user
end
