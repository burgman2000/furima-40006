require 'rails_helper'

RSpec.describe Product, type: :model do
  context '商品の出品ができない場合' do
    before do
      @product = FactoryBot.build(:product)
    end

    it 'category_idが1だと登録できない' do
      @product.category_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    it 'condition_idが1だと登録できない' do
      @product.condition_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include("Condition can't be blank")
    end

    it 'shipping_fee_idが1だと登録できない' do
      @product.shipping_fee_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include("Shipping fee can't be blank")
    end

    it 'prefecture_idが1だと登録できない' do
      @product.prefecture_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'shipping_day_idが1だと登録できない' do
      @product.shipping_day_id = 1
      @product.valid?
      expect(@product.errors.full_messages).to include("Shipping day can't be blank")
    end

    # 他のバリデーションに関するテストケースを追加する際、それに対応するコードを記述してください
  end
end