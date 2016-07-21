module ApplicationHelper

	def page_title

		app_name = t(:app_name)
		action = t("titles.#{controller_name}.#{action_name}", default: '')
		action += " #{object_name}" if object_name.present?
		action += " #{post_title}" if post_title.present?
		action += " - " if action.present?
		"#{action} #{app_name}"
		
	end

	def object_name

		assigns[controller_name.singularize].name rescue nil

	end

	def post_title

		assigns[controller_name.singularize].title rescue nil

	end

end
