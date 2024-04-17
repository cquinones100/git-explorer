# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `tty-screen` gem.
# Please instead update this file by running `bin/tapioca gem tty-screen`.

# source://tty-screen//lib/tty/screen/version.rb#3
module TTY; end

# Responsible for detecting terminal screen size
#
# @api public
#
# source://tty-screen//lib/tty/screen/version.rb#4
module TTY::Screen
  private

  # Detect terminal screen width
  #
  # @api public
  # @example
  #   TTY::Screen.width # => 211
  # @return [Integer]
  #
  # source://tty-screen//lib/tty/screen.rb#128
  def cols; end

  # Detect terminal screen width
  #
  # @api public
  # @example
  #   TTY::Screen.width # => 211
  # @return [Integer]
  #
  # source://tty-screen//lib/tty/screen.rb#128
  def columns; end

  # Check if a command exists
  #
  # @api private
  # @param command [String] the command to check
  # @return [Boolean]
  #
  # source://tty-screen//lib/tty/screen.rb#442
  def command_exist?(command); end

  # Detect terminal screen height
  #
  # @api public
  # @example
  #   TTY::Screen.height # => 51
  # @return [Integer]
  #
  # source://tty-screen//lib/tty/screen.rb#146
  def height; end

  # Check if the ioctl call gets window size on any standard stream
  #
  # @api private
  # @param control [Integer] the control code
  # @param buf [String] the window size buffer
  # @return [Boolean] true if the ioctl call gets window size, false otherwise
  #
  # source://tty-screen//lib/tty/screen.rb#331
  def ioctl?(control, buf); end

  # source://tty-screen//lib/tty/screen.rb#55
  def jruby?; end

  # Detect terminal screen height
  #
  # @api public
  # @example
  #   TTY::Screen.height # => 51
  # @return [Integer]
  #
  # source://tty-screen//lib/tty/screen.rb#146
  def lines; end

  # Check if a number is non-zero
  #
  # @api private
  # @param column [Integer, String] the column to check
  # @return [Boolean]
  #
  # source://tty-screen//lib/tty/screen.rb#476
  def nonzero_column?(column); end

  # Detect terminal screen height
  #
  # @api public
  # @example
  #   TTY::Screen.height # => 51
  # @return [Integer]
  #
  # source://tty-screen//lib/tty/screen.rb#146
  def rows; end

  # Run command capturing the standard output
  #
  # @api private
  # @param args [Array<String>] the command arguments
  # @return [String, nil] the command output or nil
  #
  # source://tty-screen//lib/tty/screen.rb#461
  def run_command(*args); end

  # Detect terminal screen size
  #
  # @api public
  # @example
  #   TTY::Screen.size # => [51, 211]
  # @return [Array(Integer, Integer)] the terminal screen size
  #
  # source://tty-screen//lib/tty/screen.rb#106
  def size(verbose: T.unsafe(nil)); end

  # Detect terminal screen size from the ANSICON environment variable
  #
  # @api private
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#426
  def size_from_ansicon; end

  # Detect terminal screen size from default
  #
  # @api private
  # @return [Array(Integer, Integer)]
  #
  # source://tty-screen//lib/tty/screen.rb#161
  def size_from_default; end

  # Detect terminal screen size from environment variables
  #
  # After executing Ruby code, when the user changes terminal
  # screen size during code runtime, the code will not be
  # notified, and hence will not see the new size reflected
  # in its copy of LINES and COLUMNS environment variables.
  #
  # @api private
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#412
  def size_from_env; end

  # Detect terminal screen size from io-console
  #
  # On Windows, the io-console falls back to reading environment
  # variables. This means any user changes to the terminal screen
  # size will not be reflected in the runtime of the Ruby application.
  #
  # @api private
  # @param verbose [Boolean] the verbose mode, by default false
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#249
  def size_from_io_console(verbose: T.unsafe(nil)); end

  # Detect terminal screen size from ioctl
  #
  # @api private
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#308
  def size_from_ioctl; end

  # Detect terminal screen size from Java
  #
  # @api private
  # @param verbose [Boolean] the verbose mode, by default false
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#232
  def size_from_java(verbose: T.unsafe(nil)); end

  # Detect terminal screen size from readline
  #
  # @api private
  # @param verbose [Boolean] the verbose mode, by default false
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#353
  def size_from_readline(verbose: T.unsafe(nil)); end

  # Detect terminal screen size from stty
  #
  # @api private
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#390
  def size_from_stty; end

  # Detect terminal screen size from tput
  #
  # @api private
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#373
  def size_from_tput; end

  # Detect terminal screen size from Windows API
  #
  # @api private
  # @param verbose [Boolean] the verbose mode, by default false
  # @return [Array(Integer, Integer), nil] the terminal screen size or nil
  #
  # source://tty-screen//lib/tty/screen.rb#207
  def size_from_win_api(verbose: T.unsafe(nil)); end

  # Detect terminal screen width
  #
  # @api public
  # @example
  #   TTY::Screen.width # => 211
  # @return [Integer]
  #
  # source://tty-screen//lib/tty/screen.rb#128
  def width; end

  # source://tty-screen//lib/tty/screen.rb#42
  def windows?; end

  class << self
    # Detect terminal screen width
    #
    # @api public
    # @example
    #   TTY::Screen.width # => 211
    # @return [Integer]
    #
    # source://tty-screen//lib/tty/screen.rb#128
    def cols; end

    # Detect terminal screen width
    #
    # @api public
    # @example
    #   TTY::Screen.width # => 211
    # @return [Integer]
    #
    # source://tty-screen//lib/tty/screen.rb#128
    def columns; end

    # The environment variables
    #
    # @api public
    # @example
    #   TTY::Screen.env
    # @example
    #   TTY::Screen.env = {"ROWS" => "51", "COLUMNS" => "211"}
    # @return [Enumerable]
    #
    # source://tty-screen//lib/tty/screen.rb#81
    def env; end

    # The environment variables
    #
    # @api public
    # @example
    #   TTY::Screen.env
    # @example
    #   TTY::Screen.env = {"ROWS" => "51", "COLUMNS" => "211"}
    # @return [Enumerable]
    #
    # source://tty-screen//lib/tty/screen.rb#81
    def env=(_arg0); end

    # Detect terminal screen height
    #
    # @api public
    # @example
    #   TTY::Screen.height # => 51
    # @return [Integer]
    #
    # source://tty-screen//lib/tty/screen.rb#146
    def height; end

    # Check if the ioctl call gets window size on any standard stream
    #
    # @api private
    # @param control [Integer] the control code
    # @param buf [String] the window size buffer
    # @return [Boolean] true if the ioctl call gets window size, false otherwise
    #
    # source://tty-screen//lib/tty/screen.rb#331
    def ioctl?(control, buf); end

    # source://tty-screen//lib/tty/screen.rb#55
    def jruby?; end

    # Detect terminal screen height
    #
    # @api public
    # @example
    #   TTY::Screen.height # => 51
    # @return [Integer]
    #
    # source://tty-screen//lib/tty/screen.rb#146
    def lines; end

    # The output stream with standard error as default
    #
    # @api public
    # @example
    #   TTY::Screen.output
    # @example
    #   TTY::Screen.output = $stdout
    # @return [IO]
    #
    # source://tty-screen//lib/tty/screen.rb#94
    def output; end

    # The output stream with standard error as default
    #
    # @api public
    # @example
    #   TTY::Screen.output
    # @example
    #   TTY::Screen.output = $stdout
    # @return [IO]
    #
    # source://tty-screen//lib/tty/screen.rb#94
    def output=(_arg0); end

    # Define module method as private
    #
    # @api private
    # @return [void]
    #
    # source://tty-screen//lib/tty/screen.rb#28
    def private_module_function(name); end

    # Detect terminal screen height
    #
    # @api public
    # @example
    #   TTY::Screen.height # => 51
    # @return [Integer]
    #
    # source://tty-screen//lib/tty/screen.rb#146
    def rows; end

    # Detect terminal screen size
    #
    # @api public
    # @example
    #   TTY::Screen.size # => [51, 211]
    # @return [Array(Integer, Integer)] the terminal screen size
    #
    # source://tty-screen//lib/tty/screen.rb#106
    def size(verbose: T.unsafe(nil)); end

    # Detect terminal screen size from the ANSICON environment variable
    #
    # @api private
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#426
    def size_from_ansicon; end

    # Detect terminal screen size from default
    #
    # @api private
    # @return [Array(Integer, Integer)]
    #
    # source://tty-screen//lib/tty/screen.rb#161
    def size_from_default; end

    # Detect terminal screen size from environment variables
    #
    # After executing Ruby code, when the user changes terminal
    # screen size during code runtime, the code will not be
    # notified, and hence will not see the new size reflected
    # in its copy of LINES and COLUMNS environment variables.
    #
    # @api private
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#412
    def size_from_env; end

    # Detect terminal screen size from io-console
    #
    # On Windows, the io-console falls back to reading environment
    # variables. This means any user changes to the terminal screen
    # size will not be reflected in the runtime of the Ruby application.
    #
    # @api private
    # @param verbose [Boolean] the verbose mode, by default false
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#249
    def size_from_io_console(verbose: T.unsafe(nil)); end

    # Detect terminal screen size from ioctl
    #
    # @api private
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#308
    def size_from_ioctl; end

    # Detect terminal screen size from Java
    #
    # @api private
    # @param verbose [Boolean] the verbose mode, by default false
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#232
    def size_from_java(verbose: T.unsafe(nil)); end

    # Detect terminal screen size from readline
    #
    # @api private
    # @param verbose [Boolean] the verbose mode, by default false
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#353
    def size_from_readline(verbose: T.unsafe(nil)); end

    # Detect terminal screen size from stty
    #
    # @api private
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#390
    def size_from_stty; end

    # Detect terminal screen size from tput
    #
    # @api private
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#373
    def size_from_tput; end

    # Detect terminal screen size from Windows API
    #
    # @api private
    # @param verbose [Boolean] the verbose mode, by default false
    # @return [Array(Integer, Integer), nil] the terminal screen size or nil
    #
    # source://tty-screen//lib/tty/screen.rb#207
    def size_from_win_api(verbose: T.unsafe(nil)); end

    # Detect terminal screen width
    #
    # @api public
    # @example
    #   TTY::Screen.width # => 211
    # @return [Integer]
    #
    # source://tty-screen//lib/tty/screen.rb#128
    def width; end

    # source://tty-screen//lib/tty/screen.rb#42
    def windows?; end

    private

    # source://tty-screen//lib/tty/screen.rb#442
    def command_exist?(command); end

    # source://tty-screen//lib/tty/screen.rb#476
    def nonzero_column?(column); end

    # source://tty-screen//lib/tty/screen.rb#461
    def run_command(*args); end
  end
end

# The default terminal screen size
#
# @api private
# @return [Array(Integer, Integer)]
#
# source://tty-screen//lib/tty/screen.rb#64
TTY::Screen::DEFAULT_SIZE = T.let(T.unsafe(nil), Array)

# The Ruby configuration
#
# @api private
# @return [Hash]
#
# source://tty-screen//lib/tty/screen.rb#20
TTY::Screen::RUBY_CONFIG = T.let(T.unsafe(nil), Hash)

# The get window size control code for Linux
#
# @api private
# @return [Integer]
#
# source://tty-screen//lib/tty/screen.rb#270
TTY::Screen::TIOCGWINSZ = T.let(T.unsafe(nil), Integer)

# The ioctl window size buffer format
#
# @api private
# @return [String]
#
# source://tty-screen//lib/tty/screen.rb#291
TTY::Screen::TIOCGWINSZ_BUF_FMT = T.let(T.unsafe(nil), String)

# The ioctl window size buffer length
#
# @api private
# @return [Integer]
#
# source://tty-screen//lib/tty/screen.rb#299
TTY::Screen::TIOCGWINSZ_BUF_LEN = T.let(T.unsafe(nil), Integer)

# The get window size control code for FreeBSD and macOS
#
# @api private
# @return [Integer]
#
# source://tty-screen//lib/tty/screen.rb#277
TTY::Screen::TIOCGWINSZ_PPC = T.let(T.unsafe(nil), Integer)

# The get window size control code for Solaris
#
# @api private
# @return [Integer]
#
# source://tty-screen//lib/tty/screen.rb#284
TTY::Screen::TIOCGWINSZ_SOL = T.let(T.unsafe(nil), Integer)

# source://tty-screen//lib/tty/screen/version.rb#5
TTY::Screen::VERSION = T.let(T.unsafe(nil), String)