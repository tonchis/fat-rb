module Fat
  FatError = Class.new(StandardError)

  def self.at_string_path(hash, path)
    fields = path.split('.')
    self.at(hash, *fields)
  end

  def self.at_symbol_path(hash, path)
    fields = path.split(':').map(&:to_sym)
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

  def at_string_path(path)
    Fat.at_string_path(self, path)
  end

  def at_symbol_path(path)
    Fat.at_symbol_path(self, path)
  end

  def at(*args)
    Fat.at(self, *args)
  end
end
