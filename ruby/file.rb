require 'csv'

CSV.foreach(ENV['file'], col_sep: "|", row_sep: "\n") do |row|

      hash = Hash.new
      HEADERS.each_with_index do |item, index|
        hash[item] = row[index]
      end
      PbsMedium.create hash
end

CSV.open(fn, 'w') do |csv|
  csv << Model.column_names
  Model.where(query).each do |m|
    csv << m.attributes.values
  end
end

