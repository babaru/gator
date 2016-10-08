require 'rails_helper'

RSpec.describe Product, type: :model do
  context :diff do
    it 'finds difference from other product instance' do
      product1 = build(:test_product_1)
      product2 = build(:test_product_2)

      result = product1.diff(product2)

      expect(result).to be_a(Hash)
      expect(result.keys.count).to eq(7)
      expect(result['name']).to eq(product1.name)
      expect(result['short_name']).to eq(product1.short_name)
      expect(result['code']).to eq(product1.code)
      expect(result['client_code']).to eq(product1.client_code)
      expect(result['deposited_at']).to eq(product1.deposited_at)
      expect(result['delegation_started_at']).to eq(product1.delegation_started_at)
      expect(result['delegation_ended_at']).to eq(product1.delegation_ended_at)
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
