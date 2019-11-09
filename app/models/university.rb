class University < ApplicationRecord
  has_many :libraries
  enum active_status: [:active, :inactive]

  after_save :inactive_libraries, if: :saved_change_to_active_status?

  private

    def inactive_libraries
      if self.inactive?
        self.libraries.each do |library|
          library.inactive!
        end
      end
    end
end
