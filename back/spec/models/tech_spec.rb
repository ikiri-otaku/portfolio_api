require 'rails_helper'

RSpec.describe Tech, type: :model do
  describe 'バリデーション' do
    let(:tech) { FactoryBot.build(:tech) }

    describe '必須項目' do
      before do
        expect(tech.valid?).to be true
      end
      it 'name が空の場合エラーになること' do
        tech.name = nil
        expect(tech.valid?).to be false
        expect(tech.errors[:name]).to eq ["can't be blank"]
      end
    end

    describe 'サイズ' do
      it 'name が20桁を超える場合エラーになること' do
        tech.name = 'a' * 20
        expect(tech.valid?).to be true
        tech.name = 'a' * 21
        expect(tech.valid?).to be false
        expect(tech.errors[:name]).to eq ["is too long (maximum is 20 characters)"]
      end
    end

    describe '外部キー制約' do
      it 'parent に指定されているレコードを削除する場合、子の外部キーがクリアされること' do
        parent_tech = FactoryBot.create(:tech, :with_child)
        expect(parent_tech.children.length).to eq 1
        child_tech = parent_tech.children[0]
        expect(child_tech.parent_id).to eq parent_tech.id

        parent_tech.destroy!
        expect { parent_tech.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(child_tech.reload).not_to be nil
        expect(child_tech.parent_id).to be nil
      end
    end
  end
end
