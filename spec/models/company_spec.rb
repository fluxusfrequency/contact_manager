require 'spec_helper'

describe Company do

  let(:company) { Company.new(name: "Jombay") }

  it 'is valid' do
    expect(company).to be_valid
  end

  it 'is invalid without the name' do
    company.name = nil
    expect(company).to_not be_valid
  end

  it 'has an array of phone numbers' do
    expect(company.phone_numbers).to eq([])
  end

  it 'responds with its phone numbers after they are created' do
    phone_number = company.phone_numbers.build(number: '333-4444')
    expect(phone_number.number).to eq('333-4444')
  end

  it 'has an array of email addresses' do
    expect(company.email_addresses).to eq([])
  end

  it 'responds with its created email addresses' do
    company.email_addresses.build(address: 'info@jombay.com')
    expect(company.email_addresses.map(&:address)).to eq(['info@jombay.com'])
  end

  it "convert to a string with last name, first name" do
    expect(company.to_s).to eq "Jombay"
  end
end