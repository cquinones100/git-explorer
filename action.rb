# typed: strict

require 'sorbet-runtime'

class Action < T::Enum
  enums do
    CLEAR = new("\e[2J\e[f")
    HIDE_CURSOR = new("\e[?25l")
    SHOW_CURSOR = new("\e[?25h")
  end
end
