require 'spec_helper'

describe EmailAddress do
  let(:email_address) do
    EmailAddress.new(address: "johndoe@example.com", contact_id: 1, contact_type: 'Person')
  end

  it 'is valid' do
    expect(email_address).to be_valid
  end

  it 'is invalid without an address' do
    email_address.address = nil
    expect(email_address).to_not be_valid
  end

  it 'is invalid without a contact_id' do
    email_address.contact_id = nil
    expect(email_address).to_not be_valid
  end

end
