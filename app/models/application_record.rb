# ApplicationRecord, in Rails 5, is the class all models inherit from.
# Customizations and extensions needed for the app will be here, instead
# of monkey patching ActiveRecord::Base.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
