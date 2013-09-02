require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the company view', type: :feature do

  describe 'phone numbers' do

    let(:company) { Fabricate :company }
    let(:user) { company.user }

    before(:each) do
      company.phone_numbers.create(number: "555-1234")
      login_as(user)
      visit company_path(company)
    end

    it 'shows phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add new phone number' do
      expect(page).to have_link('Add Phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new phone number' do
      page.click_link('Add Phone number')
      page.fill_in('Number', with: '555-1234')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-1234')
    end

    it 'has links to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('Edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits the phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'Edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has a link to delete the phone number' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('Delete')
      end
    end

    it 'deletes the phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'Delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_number)
      expect(page).to_not have_link("Delete")
    end
  end

  describe "the email view" do

    let(:company) { Fabricate :company }
    let(:user) { company.user }

    before(:each) do
      company.email_addresses.create(address: "one@example.com")
      login_as(user)
      visit company_path(company)
    end

    it 'shows email address' do
      company.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end

    it 'has add email address link' do
      expect(page).to have_link('Add Email Address', href: new_email_address_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new email address' do
      page.click_link('Add Email Address')
      page.fill_in('Address', with: 'akash@jombay.com')
      page.click_button('Create Email address')
      expect(current_path).to eql(company_path(company))
      expect(page).to have_content('akash@jombay.com')
    end

    it 'has a link to edit email address' do
      company.email_addresses.each do |email|
        expect(page).to have_link('Edit', href: edit_email_address_path(email))
      end
    end

    it 'edits the email address' do
      email = company.email_addresses.first
      old_address = email.address

      first(:link, 'Edit').click
      page.fill_in('Address', with: 'akash1@jombay.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('akash1@jombay.com')
      expect(page).to_not have_content(old_address)
    end

    it 'has a link to delete email address' do
      company.email_addresses.each do |email|
        expect(page).to have_link('Delete')
      end
    end

    it 'deletes the email address' do
      address = company.email_addresses.first.address

      page.click_link('Delete')
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(address)
    end
  end

end