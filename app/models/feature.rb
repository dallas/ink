class Feature
	@@comments	= true
	@@tags			= false
	
	class << self
		def active?(feature)
			eval("@@#{feature}") rescue false
		end
	
		def inactive?(feature)
			!active?(feature)
		end
	
		def activate!(feature)
			eval("@@#{feature} = true") rescue 'No such feature.'
		end
		
		def deactivate!(feature)
			eval("@@#{feature} = false") rescue 'No such feature.'
		end
	end
end
