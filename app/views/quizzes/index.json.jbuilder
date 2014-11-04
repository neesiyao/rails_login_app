json.array!(@quizzes) do |quiz|
  json.extract! quiz, :id, :name, :description
  json.url test_url(quiz, format: :json)
end
