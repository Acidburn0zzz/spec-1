require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

describe "Enumerable#drop" do
  ruby_version_is '1.8.7' do
    before :each do
      @enum = EnumerableSpecs::Numerous.new(3, 2, 1, :go)
    end

    it "requires exactly one argument" do
      lambda{ @enum.drop{} }.should raise_error(ArgumentError)
      lambda{ @enum.drop(1, 2){} }.should raise_error(ArgumentError)
    end
  
    describe "passed a number n as an argument" do
      it "raise ArgumentError if n < 0" do
        lambda{ @enum.drop(-1) }.should raise_error(ArgumentError)
      end

      it "tries to convert n to an Integer using #to_int" do
        @enum.drop(2.3).to_a.should == [1, :go]
        
        obj = mock('to_int')
        obj.should_receive(:to_int).and_return(2)
        @enum.drop(obj).to_a.should == [1, :go]
      end

      it "raises a TypeError when the passed n can be coerced to Integer" do
        lambda{ @enum.drop("hat") }.should raise_error(TypeError)
        lambda{ @enum.drop(nil) }.should raise_error(TypeError)
      end

    end
  end
end
