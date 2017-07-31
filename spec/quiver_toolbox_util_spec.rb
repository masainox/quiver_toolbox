require 'spec_helper'

describe QuiverToolbox::Util do

  describe ".generate_uuid" do
    context "" do
      uuid = QuiverToolbox::Util.generate_uuid
      it '' do
        expect(uuid.size).to eq 36
      end

      it '' do
        expect(uuid.class).to eq String
      end
    end
  end


  describe ".now_unixtime" do
    context "valid" do
      before do
        @time = QuiverToolbox::Util.now_unixtime
      end

      it { expect(@time.class).to eq Fixnum }

    end
  end


end
