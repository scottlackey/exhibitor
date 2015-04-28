require 'spec_helper'
describe 'exhibitor' do
  let(:title) { 'exhibitor' }
  it { should contain_class('exhibitor') }
  it { should compile.with_all_deps }

end
