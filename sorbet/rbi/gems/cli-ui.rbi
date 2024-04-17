# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: false
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/cli-ui/all/cli-ui.rbi
#
# cli-ui-2.2.3

module CLI
end
module CLI::UI
  def self.any_key(*args, **, &blk); end
  def self.ask(*args, **, &blk); end
  def self.confirm(*args, **, &blk); end
  def self.enable_color=(arg0, &blk); end
  def self.enable_color?(*args, **, &blk); end
  def self.fmt(*args, **, &blk); end
  def self.frame(*args, **, &blk); end
  def self.frame_style=(*args, **, &blk); end
  def self.glyph(*args, **, &blk); end
  def self.link(*args, **, &blk); end
  def self.log_output_to(*args, **, &blk); end
  def self.puts(*args, **, &blk); end
  def self.raw(*args, **, &blk); end
  def self.resolve_color(*args, **, &blk); end
  def self.resolve_style(*args, **, &blk); end
  def self.resolve_text(*args, **, &blk); end
  def self.spinner(*args, **, &blk); end
  def self.with_frame_color(*args, **, &blk); end
  def self.wrap(*args, **, &blk); end
  extend T::Sig
end
class CLI::UI::OS
  def initialize(*args, **, &blk); end
  def self.current(&blk); end
  def shift_cursor_back_on_horizontal_absolute?(*args, **, &blk); end
  def suggest_arrow_keys?(*args, **, &blk); end
  def use_color_prompt?(*args, **, &blk); end
  def use_emoji?(&blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
module CLI::UI::ANSI
  def self.clear_to_end_of_line(*args, **, &blk); end
  def self.control(arg0, arg1, &blk); end
  def self.cursor_back(*args, **, &blk); end
  def self.cursor_down(*args, **, &blk); end
  def self.cursor_forward(*args, **, &blk); end
  def self.cursor_horizontal_absolute(*args, **, &blk); end
  def self.cursor_restore(*args, **, &blk); end
  def self.cursor_save(*args, **, &blk); end
  def self.cursor_up(*args, **, &blk); end
  def self.enter_alternate_screen(*args, **, &blk); end
  def self.exit_alternate_screen(*args, **, &blk); end
  def self.hide_cursor(*args, **, &blk); end
  def self.match_alternate_screen(*args, **, &blk); end
  def self.next_line(*args, **, &blk); end
  def self.previous_line(*args, **, &blk); end
  def self.printing_width(*args, **, &blk); end
  def self.sgr(arg0, &blk); end
  def self.show_cursor(*args, **, &blk); end
  def self.strip_codes(*args, **, &blk); end
  extend T::Sig
end
class CLI::UI::Color
  def code; end
  def initialize(arg0, arg1, &blk); end
  def name(*args, **, &blk); end
  def self.available(*args, **, &blk); end
  def self.lookup(*args, **, &blk); end
  def sgr(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class CLI::UI::Color::InvalidColorName < ArgumentError
  def initialize(*args, **, &blk); end
  def message(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
module CLI::UI::Spinner
  def self.current_rune(*args, **, &blk); end
  def self.index(*args, **, &blk); end
  def self.index=(arg0); end
  def self.spin(*args, **, &blk); end
  extend T::Sig
end
class CLI::UI::Spinner::SpinGroup
  def add(*args, **, &blk); end
  def all_succeeded?(*args, **, &blk); end
  def debrief(*args, **, &blk); end
  def failure_debrief(*args, **, &blk); end
  def initialize(*args, **, &blk); end
  def self.pause_mutex(*args, **, &blk); end
  def self.pause_spinners(*args, **, &blk); end
  def self.paused?(*args, **, &blk); end
  def success_debrief(*args, **, &blk); end
  def wait(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class CLI::UI::Spinner::SpinGroup::Task
  def check(*args, **, &blk); end
  def exception(*args, **, &blk); end
  def full_render(*args, **, &blk); end
  def glyph(*args, **, &blk); end
  def initialize(*args, **, &blk); end
  def inset(*args, **, &blk); end
  def inset_width(*args, **, &blk); end
  def interrupt(*args, **, &blk); end
  def partial_render(*args, **, &blk); end
  def render(*args, **, &blk); end
  def stderr; end
  def stdout; end
  def success(*args, **, &blk); end
  def title(*args, **, &blk); end
  def update_title(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class CLI::UI::ReentrantMutex < Thread::Mutex
  def count; end
  def decrease_count(thread); end
  def delete_count(thread); end
  def increase_count(thread); end
  def initialize; end
  def lock; end
  def synchronize; end
  def unlock; end
end
module CLI::UI::StdoutRouter
  def self.activate(*args, **, &blk); end
  def self.assert_enabled!(*args, **, &blk); end
  def self.current_id(*args, **, &blk); end
  def self.deactivate(*args, **, &blk); end
  def self.disable(*args, **, &blk); end
  def self.duplicate_output_to(*args, **, &blk); end
  def self.duplicate_output_to=(arg0); end
  def self.enable(*args, **, &blk); end
  def self.enabled?(*args, **, &blk); end
  def self.ensure_activated(*args, **, &blk); end
  def self.with_enabled(*args, **, &blk); end
  def self.with_id(*args, **, &blk); end
end
class CLI::UI::StdoutRouter::Writer
  def apply_line_prefix(*args, **, &blk); end
  def auto_frame_inset?(*args, **, &blk); end
  def initialize(*args, **, &blk); end
  def prepend_id(*args, **, &blk); end
  def prepend_id_for_stream(*args, **, &blk); end
  def write(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class CLI::UI::StdoutRouter::Capture
  def initialize(*args, **, &blk); end
  def print_captured_output(*args, **, &blk); end
  def print_captured_output=(arg0); end
  def run(*args, **, &blk); end
  def self.current_capture!(*args, **, &blk); end
  def self.current_capture(*args, **, &blk); end
  def self.in_alternate_screen(*args, **, &blk); end
  def self.outermost_uncaptured?(*args, **, &blk); end
  def self.stdin_synchronize(*args, **, &blk); end
  def self.with_stdin_masked(*args, **, &blk); end
  def stderr(*args, **, &blk); end
  def stdout(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class CLI::UI::StdoutRouter::Capture::BlockingInput
  def <<(*args, **kwargs, &block); end
  def advise(*args, **kwargs, &block); end
  def autoclose=(*args, **kwargs, &block); end
  def autoclose?(*args, **kwargs, &block); end
  def beep(*args, **kwargs, &block); end
  def binmode(*args, **kwargs, &block); end
  def binmode?(*args, **kwargs, &block); end
  def check_winsize_changed(*args, **kwargs, &block); end
  def clear_screen(*args, **kwargs, &block); end
  def close(*args, **kwargs, &block); end
  def close_on_exec=(*args, **kwargs, &block); end
  def close_on_exec?(*args, **kwargs, &block); end
  def close_read(*args, **kwargs, &block); end
  def close_write(*args, **kwargs, &block); end
  def closed?(*args, **kwargs, &block); end
  def console_mode(*args, **kwargs, &block); end
  def console_mode=(*args, **kwargs, &block); end
  def cooked!(*args, **kwargs, &block); end
  def cooked(*args, **kwargs, &block); end
  def cursor(*args, **kwargs, &block); end
  def cursor=(*args, **kwargs, &block); end
  def cursor_down(*args, **kwargs, &block); end
  def cursor_left(*args, **kwargs, &block); end
  def cursor_right(*args, **kwargs, &block); end
  def cursor_up(*args, **kwargs, &block); end
  def each(*args, **kwargs, &block); end
  def each_byte(*args, **kwargs, &block); end
  def each_char(*args, **kwargs, &block); end
  def each_codepoint(*args, **kwargs, &block); end
  def each_line(*args, **kwargs, &block); end
  def echo=(*args, **kwargs, &block); end
  def echo?(*args, **kwargs, &block); end
  def eof(*args, **kwargs, &block); end
  def eof?(*args, **kwargs, &block); end
  def erase_line(*args, **kwargs, &block); end
  def erase_screen(*args, **kwargs, &block); end
  def external_encoding(*args, **kwargs, &block); end
  def fcntl(*args, **kwargs, &block); end
  def fdatasync(*args, **kwargs, &block); end
  def fileno(*args, **kwargs, &block); end
  def flush(*args, **kwargs, &block); end
  def fsync(*args, **kwargs, &block); end
  def getbyte(*args, **kwargs, &block); end
  def getc(*args, **kwargs, &block); end
  def getch(*args, **kwargs, &block); end
  def getpass(*args, **kwargs, &block); end
  def gets(*args, **kwargs, &block); end
  def goto(*args, **kwargs, &block); end
  def goto_column(*args, **kwargs, &block); end
  def iflush(*args, **kwargs, &block); end
  def initialize(*args, **, &blk); end
  def inspect(*args, **kwargs, &block); end
  def internal_encoding(*args, **kwargs, &block); end
  def ioctl(*args, **kwargs, &block); end
  def ioflush(*args, **kwargs, &block); end
  def isatty(*args, **kwargs, &block); end
  def lineno(*args, **kwargs, &block); end
  def lineno=(*args, **kwargs, &block); end
  def noecho(*args, **kwargs, &block); end
  def nread(*args, **kwargs, &block); end
  def oflush(*args, **kwargs, &block); end
  def path(*args, **kwargs, &block); end
  def pathconf(*args, **kwargs, &block); end
  def pid(*args, **kwargs, &block); end
  def pos(*args, **kwargs, &block); end
  def pos=(*args, **kwargs, &block); end
  def pread(*args, **kwargs, &block); end
  def pressed?(*args, **kwargs, &block); end
  def print(*args, **kwargs, &block); end
  def printf(*args, **kwargs, &block); end
  def putc(*args, **kwargs, &block); end
  def puts(*args, **kwargs, &block); end
  def pwrite(*args, **kwargs, &block); end
  def raw!(*args, **kwargs, &block); end
  def raw(*args, **kwargs, &block); end
  def read(*args, **kwargs, &block); end
  def read_nonblock(*args, **kwargs, &block); end
  def readbyte(*args, **kwargs, &block); end
  def readchar(*args, **kwargs, &block); end
  def readline(*args, **kwargs, &block); end
  def readlines(*args, **kwargs, &block); end
  def readpartial(*args, **kwargs, &block); end
  def ready?(*args, **kwargs, &block); end
  def reopen(*args, **kwargs, &block); end
  def rewind(*args, **kwargs, &block); end
  def scroll_backward(*args, **kwargs, &block); end
  def scroll_forward(*args, **kwargs, &block); end
  def seek(*args, **kwargs, &block); end
  def set_encoding(*args, **kwargs, &block); end
  def set_encoding_by_bom(*args, **kwargs, &block); end
  def stat(*args, **kwargs, &block); end
  def sync(*args, **kwargs, &block); end
  def sync=(*args, **kwargs, &block); end
  def synchronize(*args, **, &blk); end
  def sysread(*args, **kwargs, &block); end
  def sysseek(*args, **kwargs, &block); end
  def syswrite(*args, **kwargs, &block); end
  def tell(*args, **kwargs, &block); end
  def timeout(*args, **kwargs, &block); end
  def timeout=(*args, **kwargs, &block); end
  def to_i(*args, **kwargs, &block); end
  def to_io(*args, **kwargs, &block); end
  def to_path(*args, **kwargs, &block); end
  def tty?(*args, **kwargs, &block); end
  def ungetbyte(*args, **kwargs, &block); end
  def ungetc(*args, **kwargs, &block); end
  def wait(*args, **kwargs, &block); end
  def wait_priority(*args, **kwargs, &block); end
  def wait_readable(*args, **kwargs, &block); end
  def wait_writable(*args, **kwargs, &block); end
  def winsize(*args, **kwargs, &block); end
  def winsize=(*args, **kwargs, &block); end
  def write(*args, **kwargs, &block); end
  def write_nonblock(*args, **kwargs, &block); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class InvalidName___Class_0x00___NotEnabled_3 < StandardError
end