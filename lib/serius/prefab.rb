module Serius
  class Prefab < Serius
    def initialize(args = {}, &block)
      prefab_proc = args[:prefab] || Proc.new{ |i| i}
      if block_given?
        super(args){ |i| block.call(prefab_proc.call(i),i)}
      else
        super(args){ |i| prefab_proc.call(i) }
      end
    end
  end

  class EvenInts < Prefab
    def initialize(args = {}, &block)
      args[:prefab] = Proc.new{ |i| 2*i }
      super(args, &block )
    end
  end

  class OddInts < Prefab
    def initialize(args = {}, &block)
      args[:prefab] = Proc.new{ |i| 2*i-1 }
      super(args, &block )
    end
  end
end
