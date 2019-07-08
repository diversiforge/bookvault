require 'rails_helper'

describe OpenLibraryInterface do
  before do
    allow(HTTParty).to receive(:get).and_call_original
    stub_request(:get, ol_request).to_return(status: 200, body: ol_response)
  end

  let(:ol_request) { "https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data" }
  let(:ol_response) { { "ISBN:#{isbn}" => { title: 'Test book' } }.to_json }
  let(:isbn) { '9780500276853' }
  subject { described_class.new.by_isbn(isbn) }

  it 'submits a well-formed request' do
    expect(HTTParty).to receive(:get).with(ol_request)
    subject
  end

  it 'returns the first record in the response' do
    expect(subject).to eq hash_including(title: 'Test book')
  end
end
