require 'rails_helper'

module Api
  module V1
    describe CreatePostTransaction do
      context "validate" do
        context "when validation is successful" do

          before(:all) do
          end

          it "step succeeds" do
            context = {
              body: "body", author_login: "login", title: "title"
            }

            result = subject.validate(context)

            expect(result).to be_success
            expect(result.value!).to eq(context)
          end
        end

        context "when validation fails" do
          it "step fails" do
            context = {
              body: "body", author_login: "login"
            }

            result = subject.validate(context)

            expect(result).to be_failure
            expect(result.failure).to eq({title: ["is missing"]})
          end
        end
      end

      context "persist" do
        let(:repository) { double(:repository) }
        before { allow(subject).to receive(:repository) { repository } }

        it "step is successful" do
          context = {
            body: "body", title: "title", author_login: "login"
          }
          post = double(:post)

          expect(repository).to receive(:create_with_user).with(context) { post }

          subject.create(context)
        end
      end
    end
  end
end
