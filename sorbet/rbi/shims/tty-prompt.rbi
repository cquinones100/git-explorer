# typed: true

class TTY::Prompt
  sig do
      params(
        message: String,
        options: T::Hash[Symbol, T.untyped],
        block: T.proc.params(menu: TTY::Prompt::List).void
      )
        .returns(T.any(Integer, String))
  end
  def select(message, *options, &block); end
end

class TTY::Prompt::List
  sig do
    type_parameters(:T)
      .params(
        value: T.any(String, T.type_parameter(:T), T::Hash[Symbol, T.untyped]),
        block: T.nilable(T.proc.void)
      )
        .returns(T.type_parameter(:T))
  end
  def choice(*value, &block); end
end