require 'rails_helper'

RSpec.describe PayPalPaymentsController, type: :controller do

  describe "GET #approved" do
    it "returns http success" do
      get :approved
      expect(response).to have_http_status(:success)
    end
  end

end
