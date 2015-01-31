require 'csv'
require 'json'
require 'awesome_print'

@relative_path_to_source = ARGV[0]
@relative_path_to_output = ARGV[1]

# Print source to screen

print "\n source: "
ap @relative_path_to_source

# Print output to screen

print "\n output: "
ap @relative_path_to_output.split('.')[1] + '.txt'


# Method to write file with default

def write_file(value, mode='a', relative_path_to_file=@relative_path_to_output)
  File.open(relative_path_to_file, mode){ |file| file.write(value) }
end

# Method to that takes the row and makes it nice json

def csv_row_to_json(row)
  JSON.pretty_generate(row.to_hash)
end

# Read the CSV File

csv = CSV.read(@relative_path_to_source, {:encoding => 'windows-1251:utf-8',
                                          :headers => true,
                                          :header_converters => :symbol,
                                          :return_headers => true})

#
# CSV Object
# construct a json array to hold the each hash
#

csv.each do |row|

  # Write Array open if this is the first row.
  if row == csv.first
    write_file '[', 'w'
  end

  # Write Array close if this is the last row.
  # Else write as normal.
  if row == csv[csv.length]

    write_file ']'

  else

    write_file csv_row_to_json row
    write_file ','

  end
end
