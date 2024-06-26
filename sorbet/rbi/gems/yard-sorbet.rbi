# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: false
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/yard-sorbet/all/yard-sorbet.rbi
#
# yard-sorbet-0.8.1

module YARDSorbet
end
module YARDSorbet::Directives
  def self.add_directives(*args, **, &blk); end
  def self.extract_directives(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
module YARDSorbet::Handlers
end
class YARDSorbet::Handlers::AbstractDSLHandler < YARD::Handlers::Ruby::Base
  def process(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class YARDSorbet::Handlers::EnumsHandler < YARD::Handlers::Ruby::Base
  def const_assign_node?(*args, **, &blk); end
  def process(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class YARDSorbet::Handlers::IncludeHandler < YARD::Handlers::Ruby::Base
  def included_in(*args, **, &blk); end
  def process(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class YARDSorbet::Handlers::MixesInClassMethodsHandler < YARD::Handlers::Ruby::Base
  def process(*args, **, &blk); end
  def self.mixed_in_class_methods(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class YARDSorbet::Handlers::SigHandler < YARD::Handlers::Ruby::Base
  def document_attr_methods(*args, **, &blk); end
  def merged_into_attr?(*args, **, &blk); end
  def parse_node(*args, **, &blk); end
  def parse_params(*args, **, &blk); end
  def parse_return(*args, **, &blk); end
  def parse_sig(*args, **, &blk); end
  def process(*args, **, &blk); end
  def process_attr(*args, **, &blk); end
  def process_def(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
module YARDSorbet::Handlers::StructClassHandler
  def decorate_t_struct_init(*args, **, &blk); end
  def process(*args, **, &blk); end
  def process_t_struct_props(*args, **, &blk); end
  def to_object_parameters(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
class YARD::Handlers::Ruby::ClassHandler < YARD::Handlers::Ruby::Base
  include YARDSorbet::Handlers::StructClassHandler
end
class YARDSorbet::Handlers::StructPropHandler < YARD::Handlers::Ruby::Base
  def decorate_object(*args, **, &blk); end
  def immutable?(*args, **, &blk); end
  def kw_arg(*args, **, &blk); end
  def make_prop(*args, **, &blk); end
  def params(*args, **, &blk); end
  def process(*args, **, &blk); end
  def register_attrs(*args, **, &blk); end
  def update_state(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
module YARDSorbet::NodeUtils
  def self.bfs_traverse(*args, **, &blk); end
  def self.delete_node(*args, **, &blk); end
  def self.get_method_node(*args, **, &blk); end
  def self.sibling_node(*args, **, &blk); end
  def self.sigable_node?(*args, **, &blk); end
  def self.validated_attribute_names(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
module YARDSorbet::SigToYARD
  def self.build_generic_type(*args, **, &blk); end
  def self.convert(*args, **, &blk); end
  def self.convert_aref(*args, **, &blk); end
  def self.convert_array(*args, **, &blk); end
  def self.convert_collection(*args, **, &blk); end
  def self.convert_hash(*args, **, &blk); end
  def self.convert_list(*args, **, &blk); end
  def self.convert_node(*args, **, &blk); end
  def self.convert_node_type(*args, **, &blk); end
  def self.convert_t_method(*args, **, &blk); end
  def self.convert_unknown(*args, **, &blk); end
end
class YARDSorbet::TStructProp < T::Struct
  def __t_props_generated_deserialize(*args, **); end
  def __t_props_generated_serialize(*args, **); end
  def default; end
  def doc; end
  def prop_name; end
  def self.inherited(s); end
  def source; end
  def types; end
  extend T::Props::ClassMethods
  extend T::Props::Plugin::ClassMethods
  extend T::Props::Plugin::ClassMethods
  extend T::Props::Plugin::ClassMethods
  extend T::Props::Plugin::ClassMethods
  extend T::Props::Plugin::ClassMethods
  extend T::Props::Serializable::ClassMethods
end
module YARDSorbet::TagUtils
  def self.find_tag(*args, **, &blk); end
  def self.upsert_tag(*args, **, &blk); end
  extend T::Private::Methods::MethodHooks
  extend T::Private::Methods::SingletonMethodHooks
  extend T::Sig
end
