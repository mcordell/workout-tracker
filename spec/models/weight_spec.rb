# == Schema Information
#
# Table name: weights
#
#  id         :integer          not null, primary key
#  value      :integer
#  user_id    :integer
#  unit       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Weight, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
