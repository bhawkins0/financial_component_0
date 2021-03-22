task({:writeCSV => :environment}) do
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])

  response = client.categories.get()
  categories = response['categories']
 
  #categories.each do |category|
  #  p category
  #end


#films_info is an array of hashes
headers = ["category_id", "group", "hierarchy"]
CSV.open("my_csv.csv", "w") do |csv|
  csv << headers
  categories.each do |category|
    csv << CSV::Row.new(category.keys, category.values)
  end
end


end