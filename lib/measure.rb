class Measure
  def initialize(marker, label, heading, source, submeasures)
    @marker = marker
    @label = label
    @heading = heading
    @source = source
    @submeasures = submeasures
  end

  attr_reader :source, :label, :marker, :heading, :submeasures

  def measures(marker)
    submeasures.filter {|sm| sm.marker == marker }
  end
end
