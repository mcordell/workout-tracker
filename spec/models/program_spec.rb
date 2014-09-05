# == Schema Information
#
# Table name: programs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  active       :boolean
#  program_type :string(255)
#

require 'rails_helper'

RSpec.describe Program, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
