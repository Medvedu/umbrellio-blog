require 'rails_helper'

module Api
  module V1
    describe PostSchema do
      let(:result) { subject.call(attributes) }

      context "when all attributes are specified" do
        let(:attributes) do
          { title: "My title", body: "My body", author_login: "Login" }
        end

        it "is valid" do
          expect(result).to be_success
        end
      end

      context "when a title is too long" do
        let(:attributes) do
          { title: "z" * 31 }
        end

        it "is invalid" do
          expect(result).to be_failure
          expect(result.errors[:title])
            .to eq(["size cannot be greater than 30"])
        end
      end

      context "when a title is not specified" do
        let(:attributes) {{}}

        it "is invalid" do
          attributes[:title] = nil

          expect(result).to be_failure
          expect(result.errors[:title]).to eq(["must be filled"])
        end
      end
    end
  end
end
