require 'spec_helper'

RSpec.describe QuiverToolbox::CLI::Notebook do
  Timecop.freeze('2017-07-10')

  let(:valid_name) { 'My title' }
  let(:valid_uuid) { 'MYUUID' }
  let(:tmp_dir) { './spec/tmp/cli_notebook/' }
  let(:valid_options) do
    {
      'uuid' => 'MYUUID',
      'path' => tmp_dir
    }
  end


  describe '.exit_on_failure?' do
    context 'valid file' do
      it do
        expect(QuiverToolbox::CLI::Notebook.exit_on_failure?).to be true
      end
    end
  end


  describe '#create' do
    context 'valid' do
      context 'valid params 01' do

        before do
          @cli = QuiverToolbox::CLI::Notebook.new.invoke(:create, [valid_name], valid_options)
        end

        it { expect(@cli.class).to eq QuiverToolbox::CLI::Notebook }
        it { expect(@cli.api.class).to eq QuiverToolbox::API::CreateNotebook }
        it { expect(@cli.api.result).to eq './spec/tmp/cli_notebook/MYUUID.qvnotebook' }

        after do
          FileUtils.rm_rf(tmp_dir)
        end
      end
    end
  end
end
