require 'spec_helper'

RSpec.describe QuiverToolbox::CLI::Note do
  Timecop.freeze('2017-07-10')

  let(:valid_name) { 'My title' }
  let(:valid_body) { 'MYUUID' }
  let(:tmp_dir) { './spec/tmp/cli_note/' }
  let(:valid_options) do
    {
      'uuid' => 'MYUUID',
      'path' => tmp_dir
    }
  end


  describe '.exit_on_failure?' do
    context 'valid file' do
      it do
        expect(QuiverToolbox::CLI::Note.exit_on_failure?).to be true
      end
    end
  end


  describe '#create' do
    context 'valid' do
      context 'valid params 01' do

        before do
          @cli = QuiverToolbox::CLI::Note.new.invoke(:create, [valid_name, valid_body], valid_options)
        end

        it { expect(@cli.class).to eq QuiverToolbox::CLI::Note }
        it { expect(@cli.api.class).to eq QuiverToolbox::API::CreateNote }
        it { expect(@cli.api.result).to eq './spec/tmp/cli_note/MYUUID.qvnote' }

        after do
          FileUtils.rm_rf(tmp_dir)
        end
      end
    end
  end
end
