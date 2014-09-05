# == Schema Information
#
# Table name: cycles
#
#  id                 :integer          not null, primary key
#  starting_weight_id :integer
#  program_id         :integer
#  cycle_number       :integer
#  created_at         :datetime
#  updated_at         :datetime
#  active             :boolean
#

require 'rails_helper'

RSpec.describe Cycle, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
