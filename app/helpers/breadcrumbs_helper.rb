module BreadcrumbsHelper
  def breadcrumbs
    crumbs = []

    if controller_name == "categories" && action_name == "show"
      crumbs << link_to("Home", root_path)
      crumbs << link_to("Categories", categories_path)
      crumbs << @category.name
    elsif controller_name == "products" && action_name == "show"
      crumbs << link_to("Home", root_path)
      crumbs << link_to("Categories", categories_path)
      crumbs << link_to(@product.category.name, category_path(@product.category)) if @product.category
      crumbs << @product.name
    else
      crumbs << link_to("Home", root_path)
    end

    crumbs.join(" > ").html_safe
  end
end
