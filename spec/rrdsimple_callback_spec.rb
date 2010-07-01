require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RRDSimple callback" do

  let(:jan01) {Time.utc(2010,1,1.0,0)}

  before(:each) { time_travel_to(jan01) }
  before(:each) { redis.flushdb }

  it "should yield the key on incr" do
    rrd = RRDSimple.new(:step => 60, :buckets => 60, :db => redis) do |key,value|
      @params = [ key, value ]
    end
    lambda {
      rrd.incr("foo")
    }.should change { @params }.from( nil ).to( [ 'foo:0', 1 ] )
  end

end

