# An RuItem is one to-do and represents one line of the RU.
class RuItem

  attr_reader :ru_number, :outside_inside, :long_description

  def initialize(ru_number, outside_inside, long_description)
    @ru_number, @outside_inside, @long_description = ru_number, outside_inside, long_description
  end

  def outside_inside_truncated
    outside_inside[0..40]
  end

end