require "rails_helper"

feature "Accounts" do
  let(:account) { FactoryGirl.create(:account) }
  let(:root_url) { "http://#{account.subdomain}.example.com/" }

  context "as the account owner" do
    before do
      sign_in_as(:user => account.owner, :account => account)
    end

    scenario "updating an account" do
      visit root_url
      click_link "Edit Account"
      fill_in "Name", :with => "A new name"
      click_button "Update Account"
      expect(page).to have_content("Account updated successfully.")
      expect(account.reload.name).to eq("A new name")
    end
  end
end