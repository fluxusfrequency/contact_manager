require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe '' do
  describe 'the contact view', type: :feature do

    let(:company) { Fabricate :company }
    let(:user) { company.user }

    before(:each) do
      company.phone_numbers.create(number: "555-1234")
      company.phone_numbers.create(number: "555-9786")
      login_as user
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

      page.click_link('Edit')
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has a link to delete the phone number' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('Delete', href: "/phone_numbers/#{phone.id}", method: :delete)
      end
    end

    it 'deletes the phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      page.click_link('Delete')
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_number)
      expect(page).to_not have_link("Delete", href: "/phone_numbers/#{phone.id}", method: :delete)
    end
  end

  describe "" do
    describe "the email view" do

      let(:company) { Fabricate :company }
      let(:user) { company.user }

      before(:each) do
        company.email_addresses.create(address: "akash@jombay.com")
        company.email_addresses.create(address: "akash1@jombay.com")
        login_as user
        visit company_path(company)
      end

      it 'shows email address' do
        company.email_addresses.each do |email|
          expect(page).to have_selector('li', text: email.address)
        end
      end

      it 'has add email address link' do
        expect(page).to have_link('Add email id', href: new_email_address_path(contact_id: company.id, contact_type: 'Company'))
      end

      it 'adds a new email address' do
        page.click_link('Add email id')
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

        page.click_link('Edit')
        page.fill_in('Address', with: 'akash1@jombay.com')
        page.click_button('Update Email address')
        expect(current_path).to eq(company_path(company))
        expect(page).to have_content('akash1@jombay.com')
        expect(page).to_not have_content(old_address)
      end

      it 'has a link to delete email address' do
        company.email_addresses.each do |email|
          expect(page).to have_link('Delete', href: "/email_addresses/#{email.id}", method: :delete)
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
end