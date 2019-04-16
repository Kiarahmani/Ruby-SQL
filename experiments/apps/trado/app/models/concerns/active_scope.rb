module ActiveScope
    extend ActiveSupport::Concern

    included do
        #scope :active, -> { where(active: true) }
        def active(*args); where; end
        def self.active(*args); where; end
    end
end
