require 'spec_helper'

RSpec.describe QuiverToolbox::Note do
  Timecop.freeze('2017-07-10')


  describe '.new' do
    context 'when block_given' do
      context 'valid params 01' do

        before do
          @note = valid_note_obj_01
        end

        it { expect(@note.class).to eq QuiverToolbox::Note }
        it { expect(@note.title).to eq 'My title' }
        it { expect(@note.uuid).to eq 'D2A1CC36-CC97-4701-A895-EFC98EF47026' }
        it { expect(@note.tags.size).to eq 3 }
        it { expect(@note.tags[0]).to eq 'tag1' }
      end
    end
  end


  describe '.file_name' do
    context 'valid params 01' do

      before do
        @note = valid_note_obj_01
        @target = @note.file_name
      end

      it { expect(@target).to eq 'D2A1CC36-CC97-4701-A895-EFC98EF47026.qvnote' }

    end
  end


  describe '.meta_json_hash' do
    context 'valid params 01' do
      before do
        @note = valid_note_obj_01
        @target = @note.meta_json_hash
      end

      it { expect(@target['created_at']).to eq 1403566023 }
      it { expect(@target['tags'].size).to eq 3 }
      it { expect(@target['title']).to eq 'My title' }
      it { expect(@target['updated_at']).to eq 1443042305 }
      it { expect(@target['uuid']).to eq 'D2A1CC36-CC97-4701-A895-EFC98EF47026' }
      it { expect(@target['cells']).to be nil }
    end
  end


  describe '.meta_json_string' do
    context 'valid params 01' do
      before do
        @note = valid_note_obj_01
        @target = @note.meta_json_string
      end

      let(:expect_json) { File.open(expect_meta_json_file_01).read.strip! }
      it { expect(@target).to eq expect_json }
    end
  end


  describe '.content_json_hash' do
    context 'valid params 01' do
      before do
        @note = valid_note_obj_01
        @target = @note.content_json_hash
      end

      it { expect(@target['created_at']).to be nil }
      it { expect(@target['tags']).to be nil }
      it { expect(@target['title']).to eq 'My title' }
      it { expect(@target['updated_at']).to be nil }
      it { expect(@target['uuid']).to be nil }
      it { expect(@target['cells']).to eq valid_cells_01 }
    end
  end


  describe '.content_json_string' do
    context 'valid params 01' do
      before do
        @note = valid_note_obj_01
        @target = @note.content_json_string
      end

      let(:expect_json) { File.open(expect_content_json_file_01).read.strip! }

      it { expect(@target).to eq expect_json }
    end
  end


  describe '.store_meta_json' do
    context 'valid params 01' do
      before do
        @note = valid_note_obj_01
        @target = @note.store_meta_json
        @stored_note_json = JSON.load(File.open(@note.meta_json_file).read)
      end

      it { expect(@target).to eq @note }
      it { expect(@stored_note_json['title']).to eq 'My title' }
      it { expect(@stored_note_json['tags'].size).to eq 3 }
      it { expect(@stored_note_json['uuid']).to eq 'D2A1CC36-CC97-4701-A895-EFC98EF47026' }
      it { expect(@stored_note_json['cells']).to be nil }

      after do
        FileUtils.rm_rf(valid_note_obj_01.notebook_path)
      end
    end
  end


  describe '.store_content_json' do
    context 'valid params 01' do
      before do
        @note = valid_note_obj_01
        @target = @note.store_content_json
        @stored_json = JSON.load(File.open(@note.content_json_file).read)
      end

      it { expect(@target).to eq @note }
      it { expect(@stored_json['title']).to eq 'My title' }
      it { expect(@stored_json['tags']).to be nil }
      it { expect(@stored_json['uuid']).to be nil }
      it { expect(@stored_json['cells'].size).to eq 3 }
      it { expect(@stored_json['cells'][0]['type']).to eq 'text' }
      it { expect(@stored_json['cells'][0]['data']).to eq 'Cell 01 data.' }

      after do
        FileUtils.rm_rf(valid_note_obj_01.notebook_path)
      end
    end
  end


  describe '.store' do
    context 'valid params 01' do
      before do
        @note = valid_note_obj_01
        @target = @note.store
      end

      it { expect(@target).to eq @note }

      after do
        FileUtils.rm_rf(valid_note_obj_01.notebook_path)
      end

    end
  end


  describe '.open' do
    describe 'when valid' do
      context 'valid note file' do

        before :each do
          @target = QuiverToolbox::Note.open(valid_note_file_01)
        end

        it { expect(@target.class).to be QuiverToolbox::Note }
        it { expect(@target.title).to eq '1 - Getting Started' }
        it { expect(@target.uuid).to eq 'D2A1CC36-CC97-4701-A895-EFC98EF47026' }

      end
    end

  end


  describe '#resources_dir' do
    describe 'when valid' do
      context 'valid note file 02' do
        before do
          @target = QuiverToolbox::Note.open(valid_note_file_02)
        end

        it { expect(@target.class).to be QuiverToolbox::Note }
        it { expect(@target.title).to eq '12 - Preferences' }
        it { expect(@target.uuid).to eq 'ED3C96D1-AF37-4E66-9E6B-BB2005850479' }
        it { expect(@target.resources_dir).to eq File.join(File.expand_path(valid_note_file_02), 'resources/') }

      end
    end
  end


  describe '#src_resources=' do
    describe 'when valid' do
      context 'valid note file 02' do
        before do
          @target = QuiverToolbox::Note.open(valid_note_file_02)
          @file_01 = File.join(valid_note_file_02, 'resources/12EDC7A8-A468-49BD-A742-3856B829129B.png')
          @file_02 = File.join(valid_note_file_02, 'resources/1A766DDD-68AE-4AC3-BC2D-2CE310B2A8F5.png')
          @src_files = [@file_01, @file_02]
          @target.src_resources = @src_files
        end

        it { expect(@target.resources.size).to eq 2 }
        it { expect(@target.resources[0]['src']).to eq @file_01 }
        it { expect(@target.resources[1]['src']).to eq @file_02 }

      end
    end
  end


  describe '#store_resources' do
    describe 'when valid' do
      context 'valid note file 02' do
        before do
          @target = QuiverToolbox::Note.open(valid_note_file_02)
          @file_01 = File.join(valid_note_file_02, 'resources/12EDC7A8-A468-49BD-A742-3856B829129B.png')
          @file_02 = File.join(valid_note_file_02, 'resources/1A766DDD-68AE-4AC3-BC2D-2CE310B2A8F5.png')
          @src_files = [@file_01, @file_02]
          @target.src_resources = @src_files
          @target.store_resources
        end

        it { expect(@target.resources.size).to eq 2 }
        it { expect(File.exist?(@target.resources[0]['dist'])).to be true }

        after do
          @target.resources.each do |hash|
            FileUtils.rm_rf(hash['dist'])
          end
        end
      end
    end
  end


end
