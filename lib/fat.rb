module Fat
  FatError = Class.new(StandardError)

  def self.at_path(hash, path)
    fields = parse_path(path)
    self.at(hash, *fields)
  end

  def self.at(hash, *fields)
    fields[0..-1].each_with_index do |field, index|
      hash = hash[field]
      if index != fields.length - 1 && !hash.kind_of?(Hash)
        raise Fat::FatError, "No hash found at #{fields[0..index].join(".")}"
      end
    end

    hash
  end

  def self.parse_path(path)
    fields = path.split(".")

    if fields.length == 1
      fields = path.split(":")
      fields.map(&:to_sym)
    else
      fields
    end
  end

  def at_path(*args)
    Fat.at_path(self, *args)
  end

  def at(*args)
    Fat.at(self, *args)
  end
end

