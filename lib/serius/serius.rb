module Serius
  class Serius
    attr_reader :step, :start

    def initialize(args={}, &block)
      @start = args[:start] || 1
      @i = @start
      @step = args[:step] || 1
      if block_given?
        @proc = block
      else
        @proc = args[:block]
      end
      @enum = Enumerator.new do |yielder|
        loop do
          yielder << @proc.call(_step)
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
      @i.tap{ @i += @step}
    end
  end
end
