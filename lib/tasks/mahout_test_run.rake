
namespace :mahout do
  desc 'Test recommendations'
  task recommendations: [:environment] do

    Dir.glob("#{ENV['MAHOUT_DIR']}/libexec/*.jar").each { |d| require d }

    MahoutFile = org.apache.mahout.cf.taste.impl.model.file
    model = MahoutFile.FileDataModel.new(java.io.File.new("../../test/fixtures/data.csv"))

    MahoutSimilarity = org.apache.mahout.cf.taste.impl.similarity
    similarity = MahoutSimilarity.TanimotoCoefficientSimilarity.new(model)

    MahoutNeighborhood = org.apache.mahout.cf.taste.impl.neighborhood
    neighborhood = MahoutNeighborhood.NearestNUserNeighborhood.new(5, similarity, model)

    MahoutRecommender = org.apache.mahout.cf.taste.impl.recommender
    recommender = MahoutRecommender.GenericBooleanPrefUserBasedRecommender.new(model, neighborhood, similarity)
    recommendations = recommender.recommend(8, 5)

    puts recommendations

  end
end
