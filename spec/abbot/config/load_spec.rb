require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Abbot::Config, 'load' do
  
  include Abbot::SpecHelpers

  #NOTE: The path passed to Abbot::Config should be a project root (i.e
  # a folder containing an sc-config file) not the path to the config file
  # itself.
  
  it "should load a ruby config file with .rb ext" do
    verify_ruby fixture_path('configs', 'ruby1')
  end
  
  it "should autodetect a ruby config file with no ext" do
    verify_ruby fixture_path('configs', 'ruby2')
  end

  it "should load a yaml config file with .yaml ext" do
    verify_yaml fixture_path('configs', 'yaml1')
  end
  
  it "should autodetect a yaml config file with no ext" do
    verify_yaml fixture_path('configs', 'yaml2')
  end
  
  ################################################
  ## SUPPORT METHODS

  def verify_ruby(path)
    config = Abbot::Config.load(path)
    
    # Configs always live inside of a mode.  The default mode is "all"
    # Note that :a keys are defined outside of the mode(all) block and :b keys
    # inside a mode(all) block.  the Config loader should normalize this. 
    (mode_config = config[:'mode(all)']).should_not be_nil
      (c = mode_config[:'config(block)']).should_not be_nil
      c[:a].should eql(:a)
      c[:b].should eql(:b)

      (c = mode_config[:'config(param)']).should_not be_nil
      c[:a].should eql(:a)
      c[:b].should eql(:b)

    # Check configs loaded with a mode defined
    (mode_config = config[:'mode(debug)']).should_not be_nil
      (c = mode_config[:'config(block)']).should_not be_nil
      c[:a_debug].should eql(:a)
      c[:b_debug].should eql(:b)

      (c = mode_config[:'config(param)']).should_not be_nil
      c[:a_debug].should eql(:a)
      c[:b_debug].should eql(:b)
      
      
    (c = config[:'proxy(/block)']).should_not be_nil
    c[:a].should eql(:a)
    c[:b].should eql(:b)
    
    (c = config[:'proxy(/param)']).should_not be_nil
    c[:a].should eql(:a)
    c[:b].should eql(:b)
  end
  
  def verify_yaml(path)
    config = Abbot::Config.load(path)

    (mode_config = config[:'mode(all)']).should_not be_nil
      (c = mode_config[:'config(domain)']).should_not be_nil
      c[:a].should eql('a')
      c[:b].should eql('b')

    # Check configs loaded with a mode defined
    (mode_config = config[:'mode(debug)']).should_not be_nil
      (c = mode_config[:'config(domain)']).should_not be_nil
      c[:a_debug].should eql('a')
      c[:b_debug].should eql('b')

    (c = config[:'proxy(/url)']).should_not be_nil
    c[:a].should eql('a')
    c[:b].should eql('b')
  end
  
  
    
end