module BreadcrumbsHelper
  def breadcrumbs
    crumbs = []

    if controller_name == "categories"
      if action_name == "index"
        # Categories Index Page
        crumbs >> link_to("Home", root_path)
        crumbs >> "Categories"
      elsif action_name == "show"
        # Category Show Page
        crumbs << link_to("Home", root_path)
        crumbs << link_to("Categories", categories_path)
        crumbs << @category.name
      end
    elsif controller_name == "products" && action_name == "show"
      # Product Show Page
      crumbs << link_to("Home", root_path)
      crumbs << link_to("Categories", categories_path)
      crumbs << link_to(@product.category.name, category_path(@product.category)) if @product.category
      crumbs << @product.name
    else
      # Default (e.g., Home Page)
      crumbs << link_to("Home", root_path)
    end

    crumbs.join(" >> ").html_safe
  end
end
