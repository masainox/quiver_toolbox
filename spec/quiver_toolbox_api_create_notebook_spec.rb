require 'spec_helper'

RSpec.describe QuiverToolbox::API::CreateNotebook do
  Timecop.freeze('2017-07-10')

  let(:valid_name) { 'My title' }
  let(:valid_uuid) { 'MYUUID' }
  let(:tmp_dir) { './spec/tmp/api_create_notebook/' }

  describe '.new' do
    context 'valid' do
      context 'valid params 01' do

        before do
          @api = QuiverToolbox::API::CreateNotebook.new(valid_name, valid_uuid, tmp_dir)
        end

        it { expect(@api.class).to eq QuiverToolbox::API::CreateNotebook }
        it { expect(@api.result).to be nil }
        it { expect(@api.notebook.class).to eq QuiverToolbox::Notebook }
      end
    end
  end


  describe '#store' do
    context 'valid' do
      context 'valid params 01' do

        before do
          @api = QuiverToolbox::API::CreateNotebook.new(valid_name, valid_uuid, tmp_dir)
          @target = @api.exec.store
        end

        it { expect(@target.class).to eq QuiverToolbox::API::CreateNotebook }

        after do
          FileUtils.rm_rf(tmp_dir)
        end

      end
    end
  end


end
