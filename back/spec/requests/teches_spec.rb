require 'rails_helper'

RSpec.describe 'Teches', type: :request do
  describe 'GET  /teches' do
    let(:tech_no_parent_no_child) { FactoryBot.create(:tech) }
    let(:tech_discarded) { FactoryBot.create(:tech, :discarded) }
    let(:tech_parent_1) { FactoryBot.create(:tech) }
    let(:tech_child_1) { FactoryBot.create(:tech, parent: tech_parent_1) }
    let(:tech_parent_2) { FactoryBot.create(:tech) }
    let(:tech_child_2_1) { FactoryBot.create(:tech, parent: tech_parent_2) }
    let(:tech_child_2_2) { FactoryBot.create(:tech, parent: tech_parent_2) }
    let(:tech_child_parent_discarded) { FactoryBot.create(:tech, parent: tech_discarded) }

    it 'レコードが0件の場合、空のハッシュを返す' do
      get teches_path
      expect(response).to have_http_status :ok
      expect(response.body).to eq '{}'
    end

    it '全レコードが論理削除されている場合、空のハッシュを返す' do
      tech_discarded.save!
      expect(Tech.count).to eq 1

      get teches_path
      expect(response).to have_http_status :ok
      expect(response.body).to eq '{}'
    end

    it 'parentと相互に紐づいた結果を返す' do
      tech_no_parent_no_child.save!
      tech_child_1.save!
      tech_child_2_1.save!
      tech_child_2_2.save!
      tech_child_parent_discarded.save!
      expect(Tech.count).to eq 8

      get teches_path
      expect(response).to have_http_status :ok

      json = response.parsed_body
      expect(json.length).to eq 7
      expect(json[tech_no_parent_no_child.name]).to eq []
      expect(json[tech_discarded.name]).to be nil
      expect(json[tech_parent_1.name]).to eq [tech_child_1.name]
      expect(json[tech_child_1.name]).to eq [tech_parent_1.name]
      expect(json[tech_parent_2.name]).to eq [tech_child_2_1.name, tech_child_2_2.name]
      expect(json[tech_child_2_1.name]).to eq [tech_parent_2.name]
      expect(json[tech_child_2_2.name]).to eq [tech_parent_2.name]
      expect(json[tech_child_parent_discarded.name]).to eq []
    end
  end
end
