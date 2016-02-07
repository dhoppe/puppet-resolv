require 'spec_helper'

describe 'resolv::define', :type => :define do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}
    let(:pre_condition) { 'include resolv' }
    let(:title) { 'resolv.conf' }

    context "on #{osfamily}" do
      context 'when source file' do
        let(:params) {{
          :config_file_path   => '/etc/resolv.2nd.conf',
          :config_file_source => 'puppet:///modules/resolv/common/etc/resolv.conf',
        }}

        it do
          is_expected.to contain_file('define_resolv.conf').with(
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/resolv/common/etc/resolv.conf',
            'require' => nil,
          )
        end
      end

      context 'when content string' do
        let(:params) {{
          :config_file_path   => '/etc/resolv.3rd.conf',
          :config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        }}

        it do
          is_expected.to contain_file('define_resolv.conf').with(
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => nil,
          )
        end
      end

      context 'when content template' do
        let(:params) {{
          :config_file_path     => '/etc/resolv.4th.conf',
          :config_file_template => 'resolv/common/etc/resolv.conf.erb',
        }}

        it do
          is_expected.to contain_file('define_resolv.conf').with(
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => nil,
          )
        end
      end

      context 'when content template (custom)' do
        let(:params) {{
          :config_file_path         => '/etc/resolv.5th.conf',
          :config_file_template     => 'resolv/common/etc/resolv.conf.erb',
          :config_file_options_hash => {
            'key' => 'value',
          },
        }}

        it do
          is_expected.to contain_file('define_resolv.conf').with(
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => nil,
          )
        end
      end
    end
  end
end
