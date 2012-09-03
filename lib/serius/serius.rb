module Serius
  class Serius
    attr_reader :step, :start

    def initialize(args={}, &block)
      @counter = 0
      @start = args[:start] || 1
      @i = @start
      @step = args[:step] || 1
      @negation = args[:negation] || :none
      if block_given?
        @proc = block
      else
        @proc = args[:block]
      end
      @enum = Enumerator.new do |yielder|
        loop do
          yielder << try_negate(@proc.call(_step))
        end
      end
    end

    def to_s
      "Serius:Serius #{self.object_id}"
    end

    def reset(i=@start)
      @i = i
      @enum.rewind
      self
    end
    alias_method :rewind, :reset


    def sum(n)
      take(n).inject{ |sum, i| sum += i}
    end

    private

    def method_missing(sym, *args, &block)
      if @enum.respond_to?(sym)
        if args.any?
          @enum.send(sym, *args, &block)
        else
          @enum.send(sym, &block)
        end
      else
        super
      end
    end

    def _step
      @counter += 1
      @i.tap{ @i += @step}
    end

    def try_negate(val)
      val*negate
    end

    def negate
      case @negation
      when :none
        1
      when :all
        -1
      when :even
        @counter.even? ? -1 : 1
      when :odd
        @counter.odd? ? -1 : 1
      end
    end
  end
end
