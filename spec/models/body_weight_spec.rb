# == Schema Information
#
# Table name: body_weights
#
#  id         :integer          not null, primary key
#  value      :integer
#  user_id    :integer
#  unit       :string
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe BodyWeight, type: :model do
  it_behaves_like 'weight'
end
