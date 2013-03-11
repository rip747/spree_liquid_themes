Spree::BaseHelper.module_eval do
  def breadcrumbs_json(taxon)
    crumbs = [{ :label => t(:home), :link => spree.root_path }]
    if taxon
      crumbs << { :label => t(:products), :link => products_path }
      taxon.ancestors.each do |ancestor|
        crumbs << { :label => ancestor.name, :link => seo_url(ancestor) }
      end unless taxon.ancestors.empty?
      crumbs << { :label => taxon.name, :link => seo_url(taxon) }
    else
      crumbs << { :label => t(:products), :link => products_path }
    end
    return { :breadcrumbs => crumbs }.to_json
  end
end
