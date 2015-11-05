require 'rails_helper'

module Subscribem
  RSpec.describe AccountsController, type: :controller do
    context "creates the account's schema" do
      let!(:account) { Subscribem::Account.new }
      before do
        expect(Subscribem::Account).to receive(:create_with_owner).and_return(account)
        allow(account).to receive(:valid?).and_return(true)
        allow(controller).to receive(:force_authentication!).and_return(true)
      end
      specify do
        expect(account).to receive(:create_schema)
        post :create, :account => { :name => "First Account" }, :use_route => :subscribem
      end
    end
  end
end
