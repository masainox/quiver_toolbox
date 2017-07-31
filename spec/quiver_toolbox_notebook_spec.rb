require 'spec_helper'

RSpec.describe QuiverToolbox::Notebook do

  describe '.open' do
    describe 'valid' do
      context 'valid notebook file 01' do
        before do
          @file = valid_notebook_file_01
          @target = QuiverToolbox::Notebook.open(@file)
        end

        it { expect(@target.class).to eq QuiverToolbox::Notebook }

        after do
        end
      end
    end
  end



  let(:tmp_dir) { './spec/tmp/notebook/' }

  describe '.new' do
    let(:name) { 'Test Note Book' }
    let(:uuid) { 'Test' }

    describe 'when block given' do
      context 'valid' do
        before do
          @book = QuiverToolbox::Notebook.new do |n |
            n.name = name
            n.uuid = uuid
            n.store_path = tmp_dir
          end
        end

        it { expect(@book.name).to eq name }
        it { expect(@book.uuid).to eq uuid }
        it { expect(@book.file).to eq 'Test.qvnotebook' }
        it { expect(@book.file_with_path).to eq './spec/tmp/notebook/Test.qvnotebook' }
        it { expect(@book.meta_json_file).to eq './spec/tmp/notebook/Test.qvnotebook/meta.json' }
      end
    end

    describe 'when hash given' do
      context 'valid' do
        before do
          @book = QuiverToolbox::Notebook.new({
            'name' => name,
            'uuid' => uuid,
            'store_path' => tmp_dir
          })
        end

        it { expect(@book.name).to eq name }
        it { expect(@book.uuid).to eq uuid }
        it { expect(@book.file).to eq 'Test.qvnotebook' }
        it { expect(@book.file_with_path).to eq './spec/tmp/notebook/Test.qvnotebook' }
        it { expect(@book.meta_json_file).to eq './spec/tmp/notebook/Test.qvnotebook/meta.json' }
      end
    end

  end


  describe '#meta_json_hash' do
    let(:name) { 'Test Note Book' }
    let(:uuid) { 'Test' }

    before do
      @book = QuiverToolbox::Notebook.new do |n |
        n.name = name
        n.uuid = uuid
        n.store_path = tmp_dir
      end
      @target = @book.meta_json_hash
    end

    it { expect(@target.class).to eq Hash }
    it { expect(@target['name']).to eq name }
    it { expect(@target['uuid']).to eq uuid }

  end


  describe '#meta_json_string' do
    let(:name) { 'Test Note Book' }
    let(:uuid) { 'Test' }
    let(:expect_json) { File.open(expect_notebook_meta_json_file_01).read.strip! }

    before do
      @book = QuiverToolbox::Notebook.new do |n |
        n.name = name
        n.uuid = uuid
        n.store_path = tmp_dir
      end
      @target = @book.meta_json_string
    end

    it { expect(@target.class).to eq String }
    it { expect(@target).to eq expect_json }

  end


  describe '#store' do
    let(:name) { 'Test Note Book' }
    let(:uuid) { 'Test' }
    let(:expect_json) { File.open(expect_notebook_meta_json_file_01).read.strip! }

    before do
      @book = QuiverToolbox::Notebook.new do |n |
        n.name = name
        n.uuid = uuid
        n.store_path = tmp_dir
      end
      @target = @book.store
    end

    it { expect(@target.class).to eq QuiverToolbox::Notebook }

    after do
      FileUtils.rm_rf(tmp_dir)
    end

  end

end
