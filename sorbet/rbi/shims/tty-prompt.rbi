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