require 'spec_helper'

describe Company do
  let(:company) do
    Company.new(name: "google")
  end

  it 'is valid' do
    expect(company).to be_valid
  end

  it 'is invalid without a name' do
    company.name = nil
    expect(company).to_not be_valid
  end

  it 'has an array of phone numbers' do
    expect(company.phone_numbers).to eq([])
  end

  it "responds with its phone numbers after they're created" do
    phone_number = company.phone_numbers.build(number: "333-4444")
    expect(phone_number.number).to eq('333-4444')
  end

  it "responds with its email addressess after they're created" do
    email_address = company.email_addresses.build(address: "info@example.com")
    expect(email_address.address).to eq('info@example.com')
  end

end
