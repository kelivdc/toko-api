# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  active      :boolean
#  description :string(255)
#  name        :string(255)
#  slug        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  parent_id   :integer
#
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
