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
    all = []
    submeasures.each {|sm| all += [sm, sm.all_submeasures].flatten }
    all
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
