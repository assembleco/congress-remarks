class Measure
  def initialize(marker, label, heading, source, submeasures, key)
    @marker = marker
    @label = label
    @heading = heading
    @source = source
    @submeasures = submeasures
    @key = key
  end

  attr_reader :source, :label, :marker, :heading, :submeasures, :key

  def measures(marker)
    all_submeasures.filter {|sm| sm.marker == marker }
  end

  def measure(marker, label)
    measures(marker).find {|x| x.label == label }
  end

  def all_submeasures
    @all_submeasures ||=
      begin
        all = []
        submeasures.each {|sm| all += [sm, sm.all_submeasures].flatten }
        all
      end
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
