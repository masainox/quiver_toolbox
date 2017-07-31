require 'spec_helper'

RSpec.describe QuiverToolbox::Notebook do

  describe '#build_note' do
    let(:name) { 'Test Note Book' }
    let(:uuid) { 'Test' }

    before do
      @book = QuiverToolbox::Notebook.new do |n |
        n.name = name
        n.uuid = uuid
      end

      @target = @book.build_note(valid_note_hash_01)
    end

    it { expect(@target.class).to eq QuiverToolbox::Note }
    it { expect(@target.title).to eq 'Valid Note Hash 01 Title' }
    it { expect(@target.uuid).to eq 'D2A1CC36-CC97-4701-A895-EFC98EF47026' }
    it { expect(@target.updated_at).to eq 1443042305 }

  end

end
