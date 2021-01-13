class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "The email should have 'getmainstreet.com' domain.") unless
      value =~ /\A[^@\s]+@getmainstreet.com/i
  end
end