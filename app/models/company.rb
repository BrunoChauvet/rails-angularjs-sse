class Company < ActiveRecord::Base
	def as_json(options={})
    {
      id: id,
      code: code,
      name: name
    }
  end
end
