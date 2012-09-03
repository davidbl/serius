module Serius
  class Serius
    attr_reader :step, :start

    def initialize(args={}, &block)
      @start = args[:start] || 0
      @i = @start
      @step = args[:step] || 1
      if block_given?
        @proc = block
      else
        @proc = args[:block]
      end
    end

    def next
      @proc.call(_step)
    end

    def reset(i=@start)
      @i = i
    end

    def position
      @i
    end

    def take(n, start=nil)
      reset(start) if start
      n.times.map { self.next}
    end

    def sum(n, start=nil)
      take(n,start).inject{ |sum, i| sum += i}
    end

    private

    def _step
      @i.tap{ @i += @step}
    end
  end
end
