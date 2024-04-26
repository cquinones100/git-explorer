# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `strings-ansi` gem.
# Please instead update this file by running `bin/tapioca gem strings-ansi`.

# source://strings-ansi//lib/strings/ansi/version.rb#3
module Strings
  private

  # source://strings/0.2.1/lib/strings.rb#18
  def align(*args, **kws); end

  # source://strings/0.2.1/lib/strings.rb#38
  def align_center(*args); end

  # source://strings/0.2.1/lib/strings.rb#28
  def align_left(*args); end

  # source://strings/0.2.1/lib/strings.rb#48
  def align_right(*args); end

  # source://strings/0.2.1/lib/strings.rb#58
  def ansi?(string); end

  # source://strings/0.2.1/lib/strings.rb#68
  def fold(*args); end

  # source://strings/0.2.1/lib/strings.rb#78
  def pad(*args); end

  # source://strings/0.2.1/lib/strings.rb#88
  def sanitize(string); end

  # source://strings/0.2.1/lib/strings.rb#98
  def truncate(*args); end

  # source://strings/0.2.1/lib/strings.rb#108
  def wrap(*args); end

  class << self
    # source://strings/0.2.1/lib/strings.rb#18
    def align(*args, **kws); end

    # source://strings/0.2.1/lib/strings.rb#38
    def align_center(*args); end

    # source://strings/0.2.1/lib/strings.rb#28
    def align_left(*args); end

    # source://strings/0.2.1/lib/strings.rb#48
    def align_right(*args); end

    # source://strings/0.2.1/lib/strings.rb#58
    def ansi?(string); end

    # source://strings/0.2.1/lib/strings.rb#68
    def fold(*args); end

    # source://strings/0.2.1/lib/strings.rb#78
    def pad(*args); end

    # source://strings/0.2.1/lib/strings.rb#88
    def sanitize(string); end

    # source://strings/0.2.1/lib/strings.rb#98
    def truncate(*args); end

    # source://strings/0.2.1/lib/strings.rb#108
    def wrap(*args); end
  end
end

# Helper functions for handling ANSI escape sequences
#
# source://strings-ansi//lib/strings/ansi/version.rb#4
module Strings::ANSI
  private

  # Check if string contains ANSI codes
  #
  # @api public
  # @example
  #   Strings::ANSI.ansi?("\e[33mfoo\[e0m")
  #   # => true
  # @param string [String] the string to check
  # @return [Boolean]
  #
  # source://strings-ansi//lib/strings/ansi.rb#45
  def ansi?(string); end

  # Check if string contains only ANSI codes
  #
  # @api public
  # @example
  #   Strings::ANSI.only_ansi?("\e[33mfoo\[e0m")
  #   # => false
  #
  #   Strings::ANSI.only_ansi?("\e[33m")
  #   # => false
  # @param string [String] the string to check
  # @return [Boolean]
  #
  # source://strings-ansi//lib/strings/ansi.rb#65
  def only_ansi?(string); end

  # Return a copy of string with ANSI characters removed
  #
  # @api public
  # @example
  #   Strings::ANSI.sanitize("\e[33mfoo\[e0m")
  #   # => "foo"
  # @param string [String]
  # @return [String]
  #
  # source://strings-ansi//lib/strings/ansi.rb#28
  def sanitize(string); end

  class << self
    # Check if string contains ANSI codes
    #
    # @api public
    # @example
    #   Strings::ANSI.ansi?("\e[33mfoo\[e0m")
    #   # => true
    # @param string [String] the string to check
    # @return [Boolean]
    #
    # source://strings-ansi//lib/strings/ansi.rb#45
    def ansi?(string); end

    # Check if string contains only ANSI codes
    #
    # @api public
    # @example
    #   Strings::ANSI.only_ansi?("\e[33mfoo\[e0m")
    #   # => false
    #
    #   Strings::ANSI.only_ansi?("\e[33m")
    #   # => false
    # @param string [String] the string to check
    # @return [Boolean]
    #
    # source://strings-ansi//lib/strings/ansi.rb#65
    def only_ansi?(string); end

    # Return a copy of string with ANSI characters removed
    #
    # @api public
    # @example
    #   Strings::ANSI.sanitize("\e[33mfoo\[e0m")
    #   # => "foo"
    # @param string [String]
    # @return [String]
    #
    # source://strings-ansi//lib/strings/ansi.rb#28
    def sanitize(string); end
  end
end

# The regex to match ANSI codes
#
# source://strings-ansi//lib/strings/ansi.rb#15
Strings::ANSI::ANSI_MATCHER = T.let(T.unsafe(nil), String)

# The control sequence indicator
#
# source://strings-ansi//lib/strings/ansi.rb#9
Strings::ANSI::CSI = T.let(T.unsafe(nil), String)

# The code for reseting styling
#
# source://strings-ansi//lib/strings/ansi.rb#12
Strings::ANSI::RESET = T.let(T.unsafe(nil), String)

# source://strings-ansi//lib/strings/ansi/version.rb#5
Strings::ANSI::VERSION = T.let(T.unsafe(nil), String)
