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

  context "as a user" do
    before do
      user = FactoryGirl.create(:user)
      sign_in_as(:user => user, :account => account)
    end

    scenario "cannot edit an account's information" do
      visit subscribem.edit_account_url(:subdomain => account.subdomain)
      expect(page).to have_content("You are not allowed to do that.")
    end
  end
end