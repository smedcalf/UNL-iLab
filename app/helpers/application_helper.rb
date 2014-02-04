module ApplicationHelper

	def required(data)
		"<span class='required'>*</span>#{data}".html_safe
	end
end
