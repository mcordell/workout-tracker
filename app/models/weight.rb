class Weight < ActiveRecord::Base

  before_save :defaults

  def defaults
    unit = 'lb' if unit.nil?
  end
end
