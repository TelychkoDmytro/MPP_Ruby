class HasMany
	def self.has_many(name)
		name_to_module = name.to_s.split('_').map(&:capitalize).join
		mod_name = 'HasMany' + name_to_module
		begin
			method_module = self.const_get(mod_name)
		rescue NameError
			method_module = Module.new
			self.const_set(mod_name, method_module)
			include method_module
		end
		line_no = __LINE__; method_defs = %{
			# define desired methods as an interpolated string here
		}
		method_module.module_eval method_defs, __FILE__, line_no
	end
end

class Page
	extend Has_many

	has_many :features
end
 