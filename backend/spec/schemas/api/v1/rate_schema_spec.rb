require 'rails_helper'

module Api
  module V1
    describe RateSchema do
      let(:result) {subject.call( attributes) }

      context "when all attributes are specified" do
        let(:attributes) do
          { rate: 5, post_id: 3 }
        end

        it "is valid" do
          expect(result).to be_success
        end
      end

      context "when a post id is not specified" do
        let(:attributes) {{ post_id: nil }}

        it "is invalid" do
          expect(result).to be_failure
          expect(result.errors[:post_id]).to eq(["must be filled"])
        end
      end

      context "when a post is not exists" do
        let(:attributes) do
          { post_id: -1 }
        end

        it "is invalid" do
          expect(result).to be_failure

          expect(result.errors[:post_id])
            .to eq(["post not exist"])
        end
      end

      context "when a rate is out of range" do
        let(:attributes) do
          { rate: 6 }
        end

        it "is invalid" do
          attributes[:post_id] = nil

          expect(result).to be_failure
          expect(result.errors[:rate])
            .to eq(["must be less than or equal to 5"])
        end
      end
    end
  end
end
