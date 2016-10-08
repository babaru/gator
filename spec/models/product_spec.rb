require 'rails_helper'

RSpec.describe Product, type: :model do
  context :diff do
    it 'finds difference from other product instance' do
      product1 = build(:test_product_1)
      data = { name: product1.name, short_name: product1.short_name, code: 'code',
        client_code: 'client_code' }

      result = product1.diff(data)

      expect(result).to be_a(Hash)
      expect(result.keys.length).to eq(2)
      expect(result.key?(:code)).to be(true)
      expect(result.key?(:client_code)).to be(true)
      expect(result.key?(:deposited_at)).to be(false)
      expect(result[:code]).to eq('code')
      expect(result[:client_code]).to eq('client_code')
      expect(result[:deposited_at]).to eq(nil)
    end
  end

  context :commit_diff do
    it 'commits diff and record staff info' do
      product = Product.create(name: 'Test Product 1', short_name: 'TP1',
        code: 'TP1-code', client_code: 'TP1-client-code',
        initial_fund: 10, status: 0, category: 1, rd_category: 1,
        deposited_at: Time.now, delegation_started_at: Time.now,
        delegation_ended_at: Time.now)
      diff = build(:test_product_diff_1)
      staff = build(:test_staff_1)

      expect(diff.is_committed?).not_to be(true)
      expect(product.commit_diff(diff, staff)).to be(true)
      expect(diff.is_committed?).to be(true)
      expect(product.name).to eq(diff.diff[:name])
      expect(product.code).to eq(diff.diff[:code])
    end
  end
end
