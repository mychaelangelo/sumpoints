module ApplicationHelper
  # takes 2 args, with 1st being array of errors and 2 a bloc of content
  # will wrap content with 'div form-group has-erro' if there's errors
  # otherwise wrap with form-group div
  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end


end
