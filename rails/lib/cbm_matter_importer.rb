class CbmMatterImporter

  def import(case_numbers)
    query = CbmPartiesQuery.where(case_numbers: case_numbers)
    Array.wrap(query).each do |matter|
      create_matter(matter)
    end
  end

  def create_matter(matter)
    matter_hash = matter.slice('court_code', 'case_type', 'case_number')
    Matter.find_or_create_by(matter_hash) do |m|
      m.parties_attributes = parties_attributes(matter)
    end
  end

  def parties_attributes(matter)
    attributes = Array.wrap(matter['party']).each.map {|party|
      hash = {
        "number" => party['number'],
        "role" => party['type'],
        "phone" => party['phone'],
        "email" => party['email'],
        "dob" => dob(party),
        "name_attributes" => name_attributes(party),
        "address_attributes" => address_attributes(party),
        "attorney_attributes" => attorney_attributes(party)
      }
    }
  end

  def dob(party)
    party['dob'].gsub('/','').to_i == 0 ? nil : Date.strptime(party['dob'], "%m/%d/%Y")
  end

  def name_attributes(party)
    party['name'].slice('first', 'middle', 'last', 'suffix')
  end

  def address_attributes(party)
    party['address']
  end

  def attorney_attributes(party)
    attorney_attributes = party['attorney'].slice('name', 'email', 'phone')
  end
end
