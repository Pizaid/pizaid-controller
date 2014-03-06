app_dir = File.expand_path(File.dirname(__FILE__))

require 'pizaid/controller'
require app_dir+'/spec_helper'

describe Pizaid::Controller do
  it 'should succeed to run' do
    Pizaid::Controller::run.should be_true
  end
end
