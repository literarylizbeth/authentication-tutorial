module ApplicationHelper

  def bootstrap_form_settings
     { wrapper_html: { class: "form-group" }, 
       input_html: { class: "form-control" },
       required: false }
  end

end
