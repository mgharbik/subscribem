require 'rails_helper'

module Subscribem
  RSpec.describe AccountsController, type: :controller do
    routes { Subscribem::Engine.routes }

    context "creates the account's schema" do
      let!(:account) { Subscribem::Account.new }
      before do
        expect(Subscribem::Account).to receive(:create_with_owner).and_return(account)
        allow(account).to receive(:valid?).and_return(true)
        allow(controller).to receive(:force_authentication!).and_return(true)
      end
      specify do
        post :create, :account => { :name => "First Account" }
      end
    end
  end
end
