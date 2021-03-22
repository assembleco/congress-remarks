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
    all_submeasures.filter {|sm| sm.marker == marker }
  end

  def all_submeasures
    measures = []
    submeasures.each {|sm| measures << sm.all_submeasures }
    measures.flatten
  end

  def add_submeasure(measure)
    @submeasures << measure
  end
end
