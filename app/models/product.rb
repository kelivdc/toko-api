# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  active           :boolean
#  description      :text(65535)
#  meta_description :string(255)
#  meta_keywords    :string(255)
#  meta_title       :string(255)
#  name             :string(255)
#  slug             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :bigint           not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Product < ApplicationRecord
  belongs_to :category
end
