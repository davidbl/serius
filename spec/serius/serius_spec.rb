require 'spec_helper'

describe Serius do
  it 'creates an instance using the standard new syntax' do
    s = Serius::Serius.new { |i| i }
    s.should be_a Serius::Serius
  end

  it 'creates an instance using the Serius.new... syntax' do
    s = Serius.new { |i| i }
    s.should be_a Serius::Serius
  end

  it 'has sensible defaults' do
    s = Serius.new { |i| i }
    s.step.should == 1
    s.start.should == 1
  end

  it 'honors the arguments' do
    start = 5
    step = 2
    s = Serius.new(start: start, step: step) { |i| i }
    s.step.should == step
    s.start.should == start
  end

  context 'the series methods' do
    before(:each) do
     @s = Serius.new { |i| i }
    end

    it 'steps through a series' do
      @s.next.should == 1
      @s.next.should == 2
      @s.next.should == 3
    end
    
    it 'steps at interval provided' do
      @s = Serius.new(step: 3) { |i| i }
      @s.next.should == 1
      @s.next.should == 4
      @s.next.should == 7
      @s.next.should == 10
    end

    it 'starts where directed' do
      @s = Serius.new(start: 5) { |i| i }
      @s.next.should == 5
      @s.next.should == 6
      @s.next.should == 7
    end

    it 'starts and steps as directed' do
      @s = Serius.new(start: 5, step: 2) { |i| i }
      @s.next.should == 5
      @s.next.should == 7
      @s.next.should == 9
    end

    it 'starts over if needed' do
      @s.next.should == 1
      @s.next.should == 2
      @s.next.should == 3
      @s.reset
      @s.next.should == 1
    end

    it 'start where told when resetting' do
      @s.next.should == 1
      @s.next.should == 2
      @s.next.should == 3
      @s.reset 5
      @s.next.should == 5
    end

    it 'honors aliases' do
      @s.next.should == 1
      @s.next.should == 2
      @s.next.should == 3
      @s.rewind
      @s.next.should == 1
    end

    it 'returns multiple elements' do
      @s.take(3).should == [1,2,3]
      @s.take(3).should == [4,5,6]
    end

    it 'maintains the correct position after taking multiples' do
      @s.take(3).should == [1,2,3]
      @s.take(3).should == [4,5,6]
      @s.next.should == 7
    end

    it 'should sum elements' do
      s = Serius.new { |i| i*0.25 }
      s.sum(3).should == 1.5
    end

  end #context series metthods

  context 'prefab series' do
    it 'uses prefab' do
      s = Serius::Prefab.new{ |i| i}
      s.next.should == 1
      s.take(3).should == [2,3,4]
    end

    it 'creates a prefab series that returns the even integers' do
      s = Serius::EvenInts.new
      s.next.should == 2
      s.take(3).should == [4,6,8]
    end

    it 'creates a even integer prefab series with a block that i provide' do
      s = Serius::EvenInts.new { |n| 4*n}
      s.next.should == 8
      s.take(3).should == [16,24,32]
    end

    it 'creates a even integer prefab series with a block that i provide and passes the index to it' do
      s = Serius::EvenInts.new { |n,i| 4*n*((-1)**i)}
      s.next.should == -8
      s.take(3).should == [16,-24,32]
    end

    it 'creates a prefab series that returns the odd integers' do
      s = Serius::OddInts.new
      s.next.should == 1
      s.take(3).should == [3,5,7]
    end

    it 'approximates pi' do
      s = Serius::OddInts.new { |n,i| ((-1.0)**(i+1)) / n }
      series_sum = s.sum(130_658)
      (4*series_sum).round(5).should == 3.14159
    end

  end

end
