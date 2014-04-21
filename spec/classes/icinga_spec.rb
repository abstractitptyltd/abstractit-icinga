require 'spec_helper'

describe 'icinga' do
  let(:title) { 'icinga' }

  ['Debian', 'RedHat'].each do |osfamily|
    describe "icinga class without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      it { should create_class('icinga') }
    end
  end
end