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


### Schema
#
# [ 0] :provider
# [ 1] :provider_id
# [ 2] :provider_name
# [ 3] :provider_parent_provider
# [ 4] :provider_description
# [ 5] :provider_eligibility
# [ 6] :provider_hours
# [ 7] :provider_intake__application_process
# [ 8] :provider_languages
# [ 9] :provider_program_fees
# [10] :provider_shelter_requirements
# [11] :provider_volunteer_opportunities
# [12] :provider_website_address
# [13] :address_type
# [14] :address_line1
# [15] :address_line2
# [16] :address_city
# [17] :address_province
# [18] :address_postal_code
# [19] :address_county
# [20] :address_is_primary_address
# [21] :contact_name
# [22] :contact_title
# [23] :contact_email
# [24] :contact_telephone_number
# [25] :contact_is_primary_contact
# [26] :telephone_number
# [27] :telephone_is_primary_telephone
# [28] :service_code
# [29] :service_code_description
# [30] :service_code_type_service
# [31] :service_code_out_of_resource
# [32] :geography_served_by_state_state_name