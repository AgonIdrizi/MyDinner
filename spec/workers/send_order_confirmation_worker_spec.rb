require 'rails_helper'
RSpec.describe SendOrderConfirmationWorker, type: :worker do
  describe 'Send order confirmation worker' do
  	subject { SendOrderConfirmationWorker }
  	def setup
  	  Sidekiq::Worker.clear_all
    end
  	before do
  	  @order = FactoryBot.create(:order)
  	end
    it 'sends the email' do
  	  SendOrderConfirmationWorker.perform_async(@order.id)
    end

    it 'is pushing the job to queue' do
      expect(SendOrderConfirmationWorker.jobs.size).to eq(0)
      SendOrderConfirmationWorker.perform_async(@order.id)
      expect(SendOrderConfirmationWorker.jobs.size).to eq(1)
    end
  end
end
