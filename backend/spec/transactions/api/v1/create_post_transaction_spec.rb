require 'rails_helper'

module Api
  module V1
    describe CreatePostTransaction do
      context 'validate' do
        let(:params) do
          { body: 'body', author_login: 'login', title: 'title' }
        end

        context 'when validation is successful' do
          it 'step succeeds' do
            result = subject.validate(params)

            expect(result).to be_success
            expect(result.value!).to eq(params)
          end
        end

        context 'when validation fails' do
          it 'step fails' do
            params[:title] = nil

            result = subject.validate(params)

            expect(result).to be_failure
            expect(result.failure).to eq(title: ['must be filled'])
          end
        end
      end

      context '#create' do
        let :params do
          { body: 'body', author_login: 'login', title: 'title' }
        end

        let(:repository) { double(:repository) }

        before do
          allow(subject).to receive(:repository) { repository }
        end

        it 'step is successful' do
          post = double(:post)

          expect(repository)
            .to receive(:create_with_user).with(params) { post }

          subject.create(params)
        end
      end
    end
  end
end
