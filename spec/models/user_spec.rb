require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context '新規登録できるとき' do  
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'first_nameとlast_nameが存在すれば登録できる' do
        @user.first_name = '山田'
        @user.last_name = '太郎'
        expect(@user).to be_valid
      end

      it 'first_name_kanaとlast_name_kanaが存在すれば登録できる' do
        @user.first_name_kana = 'ヤマダ'
        @user.last_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end


    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      

      it 'passwordは半角でないと登録できない' do
        @user.password = 'パスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      

      it 'passwordは半角数字のみの場合登録できない' do
        @user.password = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end



      it 'passwordは半角数字のみの場合登録できない' do
        @user.password = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end



      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc123456'
        @user.password_confirmation = 'abc1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'first_nameは空では登録できない' do
        @user.first_name =  ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_nameは空では登録できない' do
        @user.last_name =  ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name =  'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name はひらがな、カタカナ、漢字のみで入力してください")
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name はひらがな、カタカナ、漢字のみで入力してください")
      end

      it 'first_name_kanaが空では登録できない' do
        @user = User.new(first_name_kana: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'last_name_kanaが空では登録できない' do
        @user = User.new(last_name_kana: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaは全角カタカナでないと登録できない' do
        @user.first_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角カタカナで入力してください")
      end
      
      it 'last_name_kanaは全角カタカナでないと登録できない' do
        @user.last_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana は全角カタカナで入力してください")
      end    

      it 'birth_dayが空では登録できない' do
        @user = User.new(birth_day: nil)
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end