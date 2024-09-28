class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_create :generate_uuid_v7

  private

  def generate_uuid_v7
    return if %i[uuid binary].exclude?(self.class.attribute_types["id"].type)

    self.id ||= UUID7.generate
  end
end
