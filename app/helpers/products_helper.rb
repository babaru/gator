module ProductsHelper
  def product_status_label_class(product)
    case product.status
    when Gator::ProductStatus.product_statuses.running
      'label-success label'
    else
      'label'
    end
  end
end
