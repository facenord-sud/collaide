# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: rating_caches
#
#  id             :integer          not null, primary key
#  cacheable_id   :integer
#  cacheable_type :string(255)
#  avg            :float            not null
#  qty            :integer          not null
#  dimension      :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

# -*- encoding : utf-8 -*-
class RatingCache < ActiveRecord::Base
  belongs_to :cacheable, :polymorphic => true 
end
