class TechesController < ApplicationController
  def index
    teches = Tech.kept
    tech_hash = teches.index_by(&:id)

    ret = build_tech_relationships(teches, tech_hash)

    render json: ret.to_json
  end

  private

  def build_tech_relationships(teches, tech_hash)
    teches.each_with_object({}) do |tech, result|
      result[tech.name] ||= []
      next if tech.parent_id.blank? || tech_hash[tech.parent_id].blank?

      add_parent_child_relationship(tech, tech_hash, result)
    end
  end

  def add_parent_child_relationship(tech, tech_hash, result)
    parent_name = tech_hash[tech.parent_id].name
    result[tech.name] << parent_name
    result[parent_name] ||= []
    result[parent_name] << tech.name
  end
end
