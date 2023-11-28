require 'rails_helper'

RSpec.describe Product, type: :model do

  context '商品の出品ができる場合' do
    before do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.build(:product, :with_valid_price, user: @user)
    end

    it '正しい情報が揃っていれば出品できる' do
      expect(@product).to be_valid
    end

    it '異なるユーザーでも正しく出品できる' do
      another_user_product = FactoryBot.build(:product, :with_valid_price, user: FactoryBot.create(:user))
      expect(another_user_product).to be_valid
    end

    it '異なる商品でも正しく出品できる' do
      another_product = FactoryBot.build(:product, :with_valid_price, user: @user)
      expect(another_product).to be_valid
    end

    it '商品名が正しく入力されていれば出品できる' do
      @product.product_name = 'Example Product'
      expect(@product).to be_valid
    end

    it '商品説明が正しく入力されていれば出品できる' do
      @product.description = 'This is a test product.'
      expect(@product).to be_valid
    end
  end 


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

    it 'imageが空では保存できない' do
      @product.image = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Image can't be blank")
    end

    it 'product_nameが空では保存できない' do
      @product.product_name = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Product name can't be blank")
    end

    it 'descriptionが空では保存できない' do
      @product.description = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Description can't be blank")
    end

    it 'priceが空では保存できない' do
      @product.price = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end


    it 'priceが299円以下では保存できない' do
      @product.price = 299
      @product.valid?
      expect(@product.errors.full_messages).to include("Price must be greater than or equal to 300")
    end

    it 'priceが10,000,000円以上では保存できない' do
      @product.price = 10_000_000
      @product.valid?
      expect(@product.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end

    it 'priceが半角文字列では保存できない' do
      @product.price = 'abc'
      @product.valid?
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it 'priceが全角数値では保存できない' do
      @product.price = '１０００'
      @product.valid?
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it 'priceが半角英字では保存できない' do
      @product.price = 'abc'
      @product.valid?
      expect(@product.errors.full_messages).to include("Price is not a number")
    end
    
    it 'priceが全角英字では保存できない' do
      @product.price = 'ａｂｃ'  # 全角英字
      @product.valid?
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it 'ユーザーが紐付いていなければ出品できない' do
      @product.user = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("User must exist")
    end

    # 他のバリデーションに関するテストケースを追加する際、それに対応するコードを記述してください
  end
end