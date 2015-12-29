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

    scenario "updating an account with invalid attributes fails" do
      visit root_url
      click_link "Edit Account"
      fill_in "Name", :with => ""
      click_button "Update Account"
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Account could not be updated.")
    end

    context "with plans" do
      let!(:starter_plan) { FactoryGirl.create(:starter_plan) }
      let!(:extreme_plan) { FactoryGirl.create(:extreme_plan) }

      before do
        account.update_column(:plan_id, starter_plan.id)
      end

      scenario "updating an account's plan" do
        visit root_url
        click_link "Edit Account"
        select "Extreme", :from => 'Plan'
        click_button "Update Account"
        expect(page).to have_content("Account updated successfully.")
        expect(page).to have_content("You are now on the 'Extreme' plan.")
        expect(account.reload.plan).to eq(extreme_plan)
      end
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