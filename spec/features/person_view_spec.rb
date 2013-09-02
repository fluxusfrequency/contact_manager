require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do

  describe 'phone numbers' do

    let(:person) { Fabricate :person }
    let(:user) { person.user }

    before(:each) do
      person.phone_numbers.create(number: "555-1234")
      person.phone_numbers.create(number: "555-5678")
      login_as(user)
      visit person_path(person)
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add Phone Number', href: new_phone_number_path(contact_id: person.id, contact_type: 'Person'))
    end

    it 'adds a new phone number' do
      page.click_link('Add Phone Number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('Edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'Edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('Delete')
      end
    end

  end

  describe 'email addresses' do

    let(:person) { Fabricate :person }
    let(:user) { person.user }

    before(:each) do
      person.email_addresses.create(address: "johndoe@google.com")
      person.email_addresses.create(address: "janedoe@google.com")
      login_as(user)
      visit person_path(person)
    end

    it 'has an li selector for each email address' do
      person.email_addresses.each do |email_address|
        expect(page).to have_selector('li', text: email_address.address)
      end
    end

    it 'has a link to add a new email_address' do
      expect(page).to have_link('Add Email Address', href: new_email_address_path(contact_id: person.id, contact_type: 'Person'))
    end

    it 'adds a new email address' do
      page.click_link('Add Email Address')
      page.fill_in('Address', with: 'alice@msn.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('alice@msn.com')
    end

    it 'has links to edit email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_link('Edit', href: edit_email_address_path(email))
      end
    end

    it 'edits a email address' do
      email = person.email_addresses.first
      old_email = email.address

      first(:link, 'Edit').click
      page.fill_in('Address', with: 'johndoe2@google.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('johndoe2@google.com')
      expect(page).to_not have_content(old_email)
    end

    it 'has links to delete email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_link('Delete')
      end
    end

  end

end