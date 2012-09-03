require "serius/version"
require "serius/serius"
require "serius/prefab"

module Serius

  class << self
    def new(args={}, &block)
      Serius.new(args.merge( block: block))
    end
  end

end
