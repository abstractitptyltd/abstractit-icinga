#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'icinga::install', :type => :class do
  let(:pre_condition){ 'class{"icinga::params":}'}
  let(:pre_condition){ 'class{"icinga":}'}
  on_supported_os({
      :hardwaremodels => ['x86_64'],
      :supported_os   => [
        {
          "operatingsystem" => "Ubuntu",
          "operatingsystemrelease" => [
            "14.04"
          ]
        },
        {
          "operatingsystem" => "CentOS",
          "operatingsystemrelease" => [
            "7"
          ]
        }
      ],
    }).each do |os, facts|
    context "When on an #{os} system" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end
      it { is_expected.to compile.with_all_deps }
      context 'when fed no parameters' do
        it { should create_class('icinga::install') }
      end#no params
    end
  end
end
