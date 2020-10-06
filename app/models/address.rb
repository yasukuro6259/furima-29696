class Address < ApplicationRecord
  belongs_to :order
  # アクティブハッシュのアソシエーションは記載しなくていい？

end
