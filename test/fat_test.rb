require "cutest"
require_relative "../lib/fat"

scope do
  setup do
    {
      foo: {
        "bar" => {
          baz: :found
        }
      }
    }
  end

  test "honor key type" do |hash|
    exception = assert_raise(Fat::FatError) { Fat.at(hash, :foo, :bar, :found) }
    assert_equal "No hash found at foo.bar", exception.message

    assert_equal :found, Fat.at(hash, :foo, "bar", :baz)
  end
end

scope do
  setup do
    {
      "foo" => {
        "bar" => {
          "baz" => :found
        }
      }
    }
  end

  test "namespaced strings" do |hash|
    assert_equal :found, Fat.at_string_path(hash, "foo.bar.baz")

    exception = assert_raise(Fat::FatError) { Fat.at_string_path(hash, "foo.not.baz") }
    assert_equal "No hash found at foo.not", exception.message
  end
end

scope do
  setup do
    {
      foo: {
        bar: {
          baz: :found
        }
      }
    }
  end

  test "namespaced symbols" do |hash|
    assert_equal :found, Fat.at_symbol_path(hash, "foo:bar:baz")

    exception = assert_raise(Fat::FatError) { Fat.at_symbol_path(hash, "foo:not:baz") }
    assert_equal "No hash found at foo.not", exception.message
  end
end

scope do
  setup do
    Hash.include(Fat)

    {
      "foo" => {
        "bar" => {
          "baz" => :found
        }
      }
    }
  end

  test "include the module" do |hash|
    assert hash.respond_to?(:at)
  end

  test "honor Fat interface" do |hash|
    assert_equal :found, hash.at("foo", "bar", "baz")
    assert_equal :found, hash.at_string_path("foo.bar.baz")
  end
end

scope do
  setup do
    Hash.include(Fat)
  end

  test "corner case" do
    assert_raise(Fat::FatError) { {}.at(:foo, :bar) }
    assert_raise(Fat::FatError) { Fat.at({}, :foo, :bar) }
  end
end

