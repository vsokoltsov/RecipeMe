require 'rails_helper'

describe "API Recipes controller" do
  let!(:access_token) { create :access_token }
  let!(:user) { create :user }
  let!(:category) { create :category }
  let!(:recipes) { create_list :recipe, 12, user_id: user.id, category_id: category.id }
  let!(:recipe) { recipes.first }

  context "unauthorized" do
    let!(:api_path) { "/api/v1/recipes" }
    it_behaves_like "API Authenticable"
  end


  describe "GET #index" do
    before { get "/api/v1/recipes", access_token: access_token.token, format: :json }

    %w(id title description rate user image persons difficult time).each do |attr|
      it "recipe in recipes list contains #{attr}" do
        expect(response.body).to be_json_eql(recipe.send(attr.to_sym).to_json).at_path("0/#{attr}")
      end
    end

    it "return 200 status" do
      expect(response.status).to eq(200)
    end
  end
end