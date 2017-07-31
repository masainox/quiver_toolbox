require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
end

require 'timecop'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'quiver_toolbox'

def fixtures_path; 'spec/fixtures/'; end
def tmp_path ; "spec/tmp/" ; end

require 'spec_valid_helper'
require 'spec_expect_helper'
