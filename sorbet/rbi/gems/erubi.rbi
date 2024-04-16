# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/erubi/all/erubi.rbi
#
# erubi-1.12.0

module Erubi
  def self.h(arg0); end
end
class Erubi::Engine
  def add_code(code); end
  def add_expression(indicator, code); end
  def add_expression_result(code); end
  def add_expression_result_escaped(code); end
  def add_postamble(postamble); end
  def add_text(text); end
  def bufvar; end
  def filename; end
  def handle(indicator, code, tailch, rspace, lspace); end
  def initialize(input, properties = nil); end
  def src; end
  def terminate_expression; end
  def with_buffer; end
end
