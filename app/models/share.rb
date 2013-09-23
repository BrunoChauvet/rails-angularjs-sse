class Share < ActiveRecord::Base
	belongs_to :company

  def as_json(options={})
    {
      id: id,
      company_id: company.id,
      value: value,
      timestamp: timestamp
    }
  end
end
