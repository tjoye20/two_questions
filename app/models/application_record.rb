class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def create_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists?(:uuid => uuid)
  end
end
