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
    submeasures.each {|sm| measures += sm.all_submeasures }
    measures
  end

  def add_submeasure(measure)
    @submeasures << measure
  end

  def inspect
    "[#{marker} #{label}\t:#{source.chars.first(64).join.gsub("\n", "\u23ce")}]"
  end

  def to_s
    "[#{marker} #{label}\t:#{source.chars.first(64).join.gsub("\n", "\u23ce")}]"
  end
end
