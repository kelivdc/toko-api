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
class Category < ApplicationRecord
  validates :slug, length: { in: 1..100 }, presence: true, uniqueness: true
  scope :published, -> { where(active: true).order(name: :asc) }

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "slug", "name"]
  end
end
