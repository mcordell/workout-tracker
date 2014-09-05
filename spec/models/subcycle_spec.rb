# == Schema Information
#
# Table name: subcycles
#
#  id         :integer          not null, primary key
#  cycle_id   :integer
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Subcycle, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
