require 'rails_helper'

module Api
  module V1
    # describe CreateRateTransaction do
    #   context "validate" do
    #     context "when validation is successful" do
    #       it "step succeeds" do
    #         context = {
    #           rate: 1, post_id: 5
    #         }
    #
    #         result = subject.validate(context)
    #
    #         expect(result).to be_success
    #         expect(result.value).to eq(context)
    #       end
    #     end
    #
    #     context "when validation fails" do
    #       it "step fails" do
    #         context = {
    #           rate: 1
    #         }
    #
    #         result = subject.validate(context)
    #
    #         expect(result).to be_failure
    #         expect(result.failure).to eq({ post_id: ["is missing"] })
    #       end
    #     end
    #   end
    #
    #   context "persist" do
    #     let(:repository) {double(:repository)}
    #     before {allow(subject).to receive(:repository) {repository}}
    #
    #     it "step is successful" do
    #       context = {
    #         body: "body", title: "title", author_login: "login"
    #       }
    #       post = double(:post)
    #
    #       expect(repository).to receive(:create_with_user).with(context) {post}
    #
    #       subject.create(context)
    #     end
    #   end
    # end
  end
end
