# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	
	def site_messages
		messages = [:notice, :error, :warning, :message]
		html = '<div id="messages">'
		messages.each do |message|
			html += content_tag('p', flash[message], :class => message.to_s) unless flash[message].blank?
		end
		html += '</div>'
	end
	
	def messages_for(what)
		messages = [:notice, :error, :warning, :message].map {|m| "#{what}_#{m}".to_sym}
		html = %(<div id="messages_for_#{what}" class="messages">)
		messages.each do |message|
			html += content_tag('p', flash[message], :class => message.to_s.split("#{what}_").last) unless flash[message].blank?
		end
		html += '</div>'
	end
	
	def link_to_top(name = 'top', element_id_or_name = 'top', html_options = {})
		html_options.reverse_update(:id => 'link_to_top')
		link_to(name, "##{element_id_or_name}", html_options)
	end
	
	def textile
		%(<span class="use_textile">(You may use #{link_to('Textile', 'http://textism.com/tools/textile/', :target => '_blank')} formatting.)</span>)
	end
end
