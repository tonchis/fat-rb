module Fat
  FatError = Class.new(StandardError)

  def self.at(hash, *args, **keywords)
    value = hash

    args.each_with_index do |field, index|
      value = hash[field]
      if value.nil?
        if !keywords.empty?
          return keywords[:default]
        else
          raise Fat::FatError, "#{fields[0..index].join(".")} is nil"
        end
      end
    end

    value
  end

  def at(*args, **keywords)
    Fat.at(self, *args, keywords)
  end
end

