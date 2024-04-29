# typed: strict

require 'sorbet-runtime'

class Key < T::Enum
  enums do
    CTRL_C = new("\u0003")
    ESCAPE = new("\e")
    BACKSPACE = new("\u007F")
  end
end
