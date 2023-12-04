require 'rails_helper'

RSpec.describe BuyerShipment, type: :model do
  describe '購入情報の保存' do
      before do
        user = FactoryBot.create(:user)
        product = FactoryBot.create(:product)
        @buyer_shipment = FactoryBot.build(:buyer_shipment, user_id: user.id, product_id: product.id)
        sleep 1
        
      end

      context '内容に問題ない場合' do
        it 'すべての値が正しく入力されていれば保存できること' do
          expect(@buyer_shipment).to be_valid
        end

        it '建物名の記入がなくても登録できること' do
          @buyer_shipment.building_name = ''
          expect(@buyer_shipment).to be_valid
        end


      end

      context '内容に問題がある場合' do
        it 'postal_codeが空だと保存できない' do
          @buyer_shipment.postal_code = ''
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:postal_code]).to include('は「3桁ハイフン4桁」の半角文字列で入力してください')
        end
        it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
          @buyer_shipment.postal_code = '1234567'
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:postal_code]).to include('は「3桁ハイフン4桁」の半角文字列で入力してください')
        end
        it 'prefecture_idが1だと登録できない' do
          @buyer_shipment.prefecture_id = 1
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:prefecture_id]).to include('は1以外の値にしてください')
        end
        it 'cityが空だと保存できないこと' do
          @buyer_shipment.city = ''
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:city]).to include("can't be blank")
        end
        it 'street_addressが空だと保存できないこと' do
          @buyer_shipment.street_address = ''
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:street_address]).to include("can't be blank")
        end
        it 'phone_numberが空だと保存できないこと' do
          @buyer_shipment.phone_number = ''
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:phone_number]).to include("can't be blank")
        end
        it 'phone_numberが10桁未満だと保存できないこと' do
          @buyer_shipment.phone_number = '123456789'  # 9桁の例
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:phone_number]).to include('は10桁以上11桁以内の半角数値で入力してください')
        end
    
        it 'phone_numberが11桁を超えると保存できないこと' do
          @buyer_shipment.phone_number = '123456789012'  # 12桁の例
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:phone_number]).to include('は10桁以上11桁以内の半角数値で入力してください')
        end
    
        it 'phone_numberにハイフンが含まれていると保存できないこと' do
          @buyer_shipment.phone_number = '090-1234-5678'
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors[:phone_number]).to include('は10桁以上11桁以内の半角数値で入力してください')
        end
        it 'userが紐付いていないと保存できないこと' do
          @buyer_shipment.user_id = nil
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors.full_messages).to include("User can't be blank")
        end
        it 'productが紐付いていないと保存できないこと' do
          @buyer_shipment.product_id = nil
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors.full_messages).to include("Product can't be blank")
        end   
        it "tokenが空では登録できないこと" do
          @buyer_shipment.token = nil
          @buyer_shipment.valid?
          expect(@buyer_shipment.errors.full_messages).to include("Token can't be blank")
        end 




      end
  end
end
