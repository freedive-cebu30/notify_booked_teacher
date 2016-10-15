module DefaultDeleteFlagScope
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted: false) }
  end
end
