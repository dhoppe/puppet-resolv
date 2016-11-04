require 'spec_helper'

describe 'resolv', type: :class do
  ['Debian'].each do |osfamily|
    let(:facts) do
      {
        osfamily: osfamily
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_anchor('resolv::begin') }
    it { is_expected.to contain_class('resolv::params') }
    it { is_expected.to contain_class('resolv::install') }
    it { is_expected.to contain_class('resolv::config') }
    it { is_expected.to contain_anchor('resolv::end') }

    context "on #{osfamily}" do
      # describe 'resolv::install' do
      #   context 'defaults' do
      #     it do
      #       is_expected.to contain_package('resolv').with(
      #         'ensure' => 'present',
      #       )
      #     end
      #   end

      #   context 'when package latest' do
      #     let(:params) {{
      #       :package_ensure => 'latest',
      #     }}

      #     it do
      #       is_expected.to contain_package('resolv').with(
      #         'ensure' => 'latest',
      #       )
      #     end
      #   end

      #   context 'when package absent' do
      #     let(:params) {{
      #       :package_ensure => 'absent',
      #     }}

      #     it do
      #       is_expected.to contain_package('resolv').with(
      #         'ensure' => 'absent',
      #       )
      #     end
      #     it do
      #       is_expected.to contain_file('resolv.conf').with(
      #         'ensure'  => 'present',
      #         'require' => nil,
      #       )
      #     end
      #   end

      #   context 'when package purged' do
      #     let(:params) {{
      #       :package_ensure => 'purged',
      #     }}

      #     it do
      #       is_expected.to contain_package('resolv').with(
      #         'ensure' => 'purged',
      #       )
      #     end
      #     it do
      #       is_expected.to contain_file('resolv.conf').with(
      #         'ensure'  => 'absent',
      #         'require' => nil,
      #       )
      #     end
      #   end
      # end

      describe 'resolv::config' do
        context 'defaults' do
          it do
            is_expected.to contain_file('resolv.conf').with(
              'ensure'  => 'present',
              'require' => nil
            )
          end
        end

        context 'when source dir' do
          let(:params) do
            {
              config_dir_source: 'puppet:///modules/resolv/common/etc'
            }
          end

          it do
            is_expected.to contain_file('resolv.dir').with(
              'ensure'  => 'directory',
              'force'   => false,
              'purge'   => false,
              'recurse' => true,
              'source'  => 'puppet:///modules/resolv/common/etc',
              'require' => nil
            )
          end
        end

        context 'when source dir purged' do
          let(:params) do
            {
              config_dir_purge: true,
              config_dir_source: 'puppet:///modules/resolv/common/etc'
            }
          end

          it do
            is_expected.to contain_file('resolv.dir').with(
              'ensure'  => 'directory',
              'force'   => true,
              'purge'   => true,
              'recurse' => true,
              'source'  => 'puppet:///modules/resolv/common/etc',
              'require' => nil
            )
          end
        end

        context 'when source file' do
          let(:params) do
            {
              config_file_source: 'puppet:///modules/resolv/common/etc/resolv.conf'
            }
          end

          it do
            is_expected.to contain_file('resolv.conf').with(
              'ensure'  => 'present',
              'source'  => 'puppet:///modules/resolv/common/etc/resolv.conf',
              'require' => nil
            )
          end
        end

        context 'when content string' do
          let(:params) do
            {
              config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
            }
          end

          it do
            is_expected.to contain_file('resolv.conf').with(
              'ensure'  => 'present',
              'content' => %r{THIS FILE IS MANAGED BY PUPPET},
              'require' => nil
            )
          end
        end

        context 'when content template' do
          let(:params) do
            {
              config_file_template: 'resolv/common/etc/resolv.conf.erb'
            }
          end

          it do
            is_expected.to contain_file('resolv.conf').with(
              'ensure'  => 'present',
              'content' => %r{THIS FILE IS MANAGED BY PUPPET},
              'require' => nil
            )
          end
        end

        context 'when content template (custom)' do
          let(:params) do
            {
              config_file_template: 'resolv/common/etc/resolv.conf.erb',
              config_file_options_hash: {
                'key' => 'value'
              }
            }
          end

          it do
            is_expected.to contain_file('resolv.conf').with(
              'ensure'  => 'present',
              'content' => %r{THIS FILE IS MANAGED BY PUPPET},
              'require' => nil
            )
          end
        end
      end
    end
  end
end
