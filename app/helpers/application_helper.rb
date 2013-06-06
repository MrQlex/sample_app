module ApplicationHelper

	def logo
		logo = image_tag("logo.png", :alt => "Application Exemple", :class => "round")
		link_to logo, root_path
	end
	
	#Retourne un titre basé sur la page.
	def titre
		base_titre = "Simple App du Tutoriel Ruby on Rails"
		if @titre.nil?
			base_titre
		else
			"#{base_titre} | #{@titre}"
		end
	end
end
