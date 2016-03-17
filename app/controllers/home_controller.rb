Dir.glob("#{ENV['MAHOUT_DIR']}/libexec/*.jar").each { |d| require d }
MahoutFile = org.apache.mahout.cf.taste.impl.model.file
MahoutSimilarity = org.apache.mahout.cf.taste.impl.similarity
MahoutNeighborhood = org.apache.mahout.cf.taste.impl.neighborhood
MahoutRecommender = org.apache.mahout.cf.taste.impl.recommender

class HomeController < ApplicationController
  def index
    model = MahoutFile.FileDataModel.new(java.io.File.new("#{Rails.root.to_s}/test/fixtures/data.csv"))    
    similarity = MahoutSimilarity.TanimotoCoefficientSimilarity.new(model)

    neighborhood = MahoutNeighborhood.NearestNUserNeighborhood.new(5, similarity, model)
    
    recommender = MahoutRecommender.GenericBooleanPrefUserBasedRecommender.new(model, neighborhood, similarity)
    @recommendations = recommender.recommend(8, 5, nil)
    

  end
end
