require 'spec_helper'

RSpec.describe QuiverToolbox::API::CreateNote do
  Timecop.freeze('2017-07-10')

  let(:valid_title) do
    'My title'
  end

  let(:valid_body) do
    'My body.'
  end


  describe '.new' do
    context 'valid' do
      context 'valid params 01' do

        before do
          @api = QuiverToolbox::API::CreateNote.new(valid_title, valid_body, valid_note_attributes_01)
        end

        it { expect(@api.class).to eq QuiverToolbox::API::CreateNote }
        it { expect(@api.note.title).to eq 'My title' }
        it { expect(@api.note.uuid).to eq 'MYUUID' }
        it { expect(@api.note.tags.size).to eq 3 }
        it { expect(@api.note.tags[0]).to eq 'tag1' }
      end
    end
  end


  describe '#exec' do
    context 'valid' do
      context 'valid params 01' do

        before do
          @api = QuiverToolbox::API::CreateNote.new(valid_title, valid_body, valid_note_attributes_01)
          @target = @api.exec
        end

        it { expect(@target.class).to eq QuiverToolbox::API::CreateNote }
      end
    end
  end


  describe '#store' do
    context 'valid' do
      context 'valid params 01' do

        before do
          @api = QuiverToolbox::API::CreateNote.new(valid_title, valid_body, valid_note_attributes_01)
          @target = @api.exec.store
        end

        it { expect(@target.class).to eq QuiverToolbox::API::CreateNote }

        after do
          FileUtils.rm_rf(valid_note_attributes_01['notebook_path'])
        end
      end
    end
  end

end
