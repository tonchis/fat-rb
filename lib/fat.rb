module Fat
  FatError = Class.new(StandardError)

  def self.at(hash, *args)
    fields = parse_args(*args)

    fields[0..-1].each_with_index do |field, index|
      hash = hash[field]
      if index != fields.length - 1 && !hash.kind_of?(Hash)
        raise Fat::FatError, "No hash found at #{fields[0..index].join(".")}"
      end
    end

    hash
  end

  def self.parse_args(*args)
    return args if args.length > 1

    fields = args.first.split(".")

    if fields.length == 1
      fields = args.first.split(":")

      if fields.length == 1
        raise FatError, "Single argument expected to be a namespace with dots (.) or colons (:)"
      else
        fields.map(&:to_sym)
      end
    else
      fields
    end
  end

  def at(*args)
    Fat.at(self, *args)
  end
end

