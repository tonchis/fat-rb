module Fat
  FatError = Class.new(StandardError)

  @fat ||= ->(hash, *args) do
    fields = args.length == 1 ? args.first.split(".") : args

    value = hash

    fields[0..-1].each_with_index do |field, index|
      value = value[field]
      if index != fields.length - 1 && !value.kind_of?(Hash)
        raise Fat::FatError, "No hash found at #{fields[0..index].join(".")}"
      end
    end

    value
  end

  def self.at(hash, *args)
    @fat.(hash, *args)
  end

  def at(*args)
    Fat.instance_variable_get(:@fat).(self, *args)
  end
end

